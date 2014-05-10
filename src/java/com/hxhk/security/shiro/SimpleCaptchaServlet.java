package com.hxhk.security.shiro;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SimpleCaptchaServlet extends HttpServlet {
	
	private static final String CAPTCHA_UPPER = "upper";
	private static final String CAPTCHA_LOWER = "lower";

	/** 描述  */
	private static final long serialVersionUID = -314440845042577575L;
	private int height = 100;
	private int width = 30;
	private int length = 4;
	private String upperOrLower = CAPTCHA_UPPER;

	public static final String CAPTCHA_KEY = "captcha_key";

	@Override
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		height = Integer
				.parseInt(getServletConfig().getInitParameter("height"));
		width = Integer.parseInt(getServletConfig().getInitParameter("width"));
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse response)
			throws IOException, ServletException {
		// Expire response
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		response.setHeader("Pragma", "no-cache");
		response.setDateHeader("Max-Age", 0);

		BufferedImage image = new BufferedImage(width, height,
				BufferedImage.TYPE_INT_RGB);
		Graphics2D graphics2D = image.createGraphics();
		Random r = new Random(System.currentTimeMillis());
		//String token = Long.toString(Math.abs(r.nextLong()), 36);
		String token = Long.toString(Math.abs(System.currentTimeMillis() + r.nextLong()), 36);
		// 截取长度
		if (length > 12 || length < 1) {
			length = 12;
		}
		String ch = token.substring(0, length);
		// 大小写转换
		if (upperOrLower.equals(CAPTCHA_UPPER)) {
			ch = ch.toUpperCase();
		} else if (upperOrLower.equals(CAPTCHA_LOWER)) {
			ch = ch.toLowerCase();
		}
		
		Color c = new Color(0.6662f, 0.4569f, 0.3232f);
		GradientPaint gp = new GradientPaint(30, 30, c, 15, 25, Color.white,
				true);
		graphics2D.setPaint(gp);
		Font font = new Font("Verdana", Font.CENTER_BASELINE, 26);
		graphics2D.setFont(font);
		graphics2D.drawString(ch, 2, 20);
		graphics2D.dispose();

		HttpSession session = req.getSession(true);
		session.setAttribute(CAPTCHA_KEY, ch);

		OutputStream outputStream = response.getOutputStream();
		ImageIO.write(image, "jpeg", outputStream);
		outputStream.close();

	}

}