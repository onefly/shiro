package com.hxhk.util.mail;

import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.internet.MimeUtility;

import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;


public class MailSender {

	private MimeMessage mimeMsg; // MIME邮件对象

	private Session session; // 邮件会话对象

	private Properties props; // 系统属性

	private boolean needAuth = false; // smtp是否需要认证

	private String username = ""; // smtp认证用户名和密码

	private String password = "";

	private Multipart mp; // Multipart对象,邮件内容,标题,附件等内容均添加到其中后再生成

	protected Logger log = Logger.getLogger(getClass());

	public MailSender(String smtp) {

		setSmtpHost(smtp);

		createMimeMessage();

	}

	public void setSmtpHost(String hostName) {

		log.debug("set system properties：mail.smtp.host= " + hostName);

		if (props == null)

			props = System.getProperties(); // 获得系统属性对象

		props.put("mail.smtp.host", hostName); // 设置SMTP主机

	}

	public boolean createMimeMessage() {

		try {

			log.debug(" prepare to get email object");
			session = Session.getDefaultInstance(props, null); // 获得邮件会话对象

		} catch (Exception e) {
			log.error("get email session error:" + e.toString(), e);
			return false;

		}

		try {

			mimeMsg = new MimeMessage(session); // 创建MIME邮件对象

			mp = new MimeMultipart(); // mp 一个multipart对象

			return true;

		} catch (Exception e) {
			log.error("create email object error:", e);
			return false;

		}

	}

	public void setNeedAuth(boolean need) {
		log.debug("set smtp ：mail.smtp.auth= " + need);
		if (props == null)

			props = System.getProperties();

		if (need) {

			props.put("mail.smtp.auth", "true");

		} else {

			props.put("mail.smtp.auth", "false");

		}

	}

	public void setNamePass(String name, String pass) {

		log.debug("get email user and password");
		username = name;

		password = pass;

	}

	public boolean setSubject(String mailSubject) {
		try {		
			mimeMsg.setSubject(MimeUtility.encodeText(mailSubject,"utf-8","B"));
			return true;

		} catch (Exception e) {
			log.error("set email subTitle error:" + e.toString(), e);
			return false;

		}

	}

	public boolean setBody(String mailBody) {

		try {

			BodyPart bp = new MimeBodyPart();

			// 转换成中文格式

			bp.setContent(

			""

			+ mailBody, "text/html;charset=utf-8");

			mp.addBodyPart(bp);

			return true;

		} catch (Exception e) {
			log.error("set email text error:" + e.toString(), e);
			return false;

		}

	}

	public boolean addFileAffix(String filename) {

		log.debug("add email file");
		try {

			BodyPart bp = new MimeBodyPart();

			FileDataSource fileds = new FileDataSource(filename);

			bp.setDataHandler(new DataHandler(fileds));

			bp.setFileName(fileds.getName());

			mp.addBodyPart(bp);

			return true;

		} catch (Exception e) {
			log.error("add email file error:" + e.toString(), e);
			return false;

		}

	}

	public boolean setFrom(String from) {
		log.debug("set email sender");
		String nick="";
		String name = "";//(String) Utils.getSystemProperty("MAIL_NICK");
		try {
			Resource resource = new ClassPathResource("mail/mail.properties");
			Properties nickprops = PropertiesLoaderUtils.loadProperties(resource);
			name=nickprops.getProperty("mail.nickname");
			nick=MimeUtility.encodeText(name,"utf-8","B");
			mimeMsg.setFrom(new InternetAddress(nick+" <"+from+">")); // 设置发信人

			return true;

		} catch (Exception e) {
			log.error("set email sender error:" + e.toString(), e);
			return false;

		}

	}

	public boolean setTo(String to) {

		log.debug("set email receiver");
		if (to == null)

			return false;

		try {

			mimeMsg.setRecipients(Message.RecipientType.TO, InternetAddress

			.parse(to));

			return true;

		} catch (Exception e) {
			log.error("set email sender receiver:" + e.toString(), e);
			return false;

		}

	}

	public boolean setCopyTo(String copyto) {

		if (copyto == null)

			return false;

		try {

			mimeMsg.setRecipients(Message.RecipientType.CC,

			InternetAddress.parse(copyto));

			return true;

		} catch (Exception e) {
			log.error(e.toString(), e);
			return false;

		}

	}

	public boolean sendout() {

		try {

			mimeMsg.setContent(mp);

			mimeMsg.saveChanges();
			log.debug("email is sending ...");
			Session mailSession = Session.getInstance(props, null);

			Transport transport = mailSession.getTransport("smtp");

			transport.connect((String) props.get("mail.smtp.host"), username,

			password);

			transport.sendMessage(mimeMsg, mimeMsg

			.getRecipients(Message.RecipientType.TO));

			// transport.send(mimeMsg);

			log.debug("email send success!");
			transport.close();

			return true;

		} catch (Exception e) {

			log.error("email send error:" + e.toString(), e);
						
			return false;

		}

	}

	public static String toUtf8String(String s) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < s.length(); i++) {
			char c = s.charAt(i);
			if (c >= 0 && c <= 255) {
				sb.append(c);
			} else {
				byte[] b;
				try {
					b = Character.toString(c).getBytes("utf-8");
				} catch (Exception ex) {
					b = new byte[0];
				}
				for (int j = 0; j < b.length; j++) {
					int k = b[j];
					if (k < 0)
						k += 256;
					sb.append("%" + Integer.toHexString(k).toUpperCase());
				}
			}
		}
		return sb.toString();
	}

	public static void main(String[] args) {

		String mailbody = "发送邮件测试欢迎你,<font color=red>欢迎你,java</font>";

		MailSender themail = new MailSender("smtp.sina.cn");

		themail.setNeedAuth(true);

		// 标题

		if (themail.setSubject("发送邮件测试") == false)

			return;

		// 邮件内容 支持html 如欢迎你,java</font>

		if (themail.setBody(mailbody) == false)

			return;

		// 收件人邮箱

		if (themail.setTo("529352479@qq.com") == false)

			return;

		// 发件人邮箱

		if (themail.setFrom("kahuiservice@sina.cn") == false)

			return;

		// 设置附件

		// if(themail.addFileAffix("mail.txt") == false)

		// return; //附件在本地机子上的绝对路径

		themail.setNamePass("kahuiservice@sina.cn", "kahuiservice"); // 用户名与密码,即您选择一个自己的电邮

		if (themail.sendout() == false)

			return;

	}

}
