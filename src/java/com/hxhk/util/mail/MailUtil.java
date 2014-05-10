package com.hxhk.util.mail;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.log4j.Logger;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;

import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * 邮件发送工具类
 * 
 * @author hxhk
 * 
 */
public class MailUtil {
	protected static Logger log = Logger.getLogger(MailUtil.class);
	private static final String ENCODING = "utf-8";
	private static Template template = null;

	public static void main(String[] args) {
		String templateName = "mailTemplate.ftl";
		Map map = new HashMap();
		map.put("content", "发送邮件测试欢迎你");
		MailUtil.sendMailByTemplate("529352479@qq.com", "发送邮件测试", map,
				templateName);
	}

	/**
	 * 根据邮件内容模版发送邮件
	 * 
	 * @param receiver
	 *            收件人邮箱
	 * @param subject
	 *            邮件主题
	 * @param map
	 *            邮件内容map
	 * @param templateName
	 *            邮件内容模版名称
	 * @return boolean true表示发送成功，false表示发送失败
	 */
	public static boolean sendMailByTemplate(String receiver, String subject,
			Map map, String templateName) {
		String content = null;
		Resource resource = new ClassPathResource("mail/mail.properties");
		try {
			Properties props = PropertiesLoaderUtils.loadProperties(resource);
			String server = props.getProperty("mail.server");
			String from = props.getProperty("mail.from");
			String username = props.getProperty("mail.username");
			String password = props.getProperty("mail.password");
			MailSender mail = new MailSender(server);
			mail.setNeedAuth(true);
			template = FreemarkerUtil.getTemplate(templateName);
			template.setEncoding(ENCODING);
			try {
				content = FreeMarkerTemplateUtils.processTemplateIntoString(
						template, map);
			} catch (TemplateException e) {
				log.error(
						"################### set template error #################",
						e);
			}
			// 标题
			if (mail.setSubject(subject) == false) {
				log.error("################### set mail title error #################");
				return false;
			}
			// 邮件内容 支持html 如欢迎你,java</font>
			if (mail.setBody(content) == false) {
				log.error("################### set mail content error#################");
				return false;
			}
			// 收件人邮箱
			if (mail.setTo(receiver) == false) {
				log.error("################### set mail receiver error#################");
				return false;
			}
			// 发件人邮箱
			if (mail.setFrom(from) == false) {
				log.error("################### set mail from error#################");
				return false;
			}
			// 设置附件
			// if(themail.addFileAffix("mail.txt") == false)
			// return; //附件在本地机子上的绝对路径
			mail.setNamePass(username, password); // 用户名与密码,即您选择一个自己的电邮
			if (mail.sendout() == false) {
				log.error("################### send mail error#################");
				return false;
			}
			log.debug("====================== Send Email Success!!!!=======================");
		} catch (IOException e) {
			log.error(e.toString(), e);
		}
		return true;
	}

	/**
	 * 普通文本方式发送邮件
	 * 
	 * @param receiver
	 *            收件人邮箱
	 * @param subject
	 *            邮件主题
	 * @param content
	 *            邮件内容
	 * @return boolean true表示发送成功，false表示发送失败
	 */
	public static boolean sendMail(String receiver, String subject,
			String content) {
		Resource resource = new ClassPathResource("mail/mail.properties");
		try {
			Properties props = PropertiesLoaderUtils.loadProperties(resource);
			String server = props.getProperty("mail.server");
			String from = props.getProperty("mail.from");
			String username = props.getProperty("mail.username");
			String password = props.getProperty("mail.password");
			String temp = props.getProperty("mail.template");
			MailSender mail = new MailSender(server);
			mail.setNeedAuth(true);
			Map root = new HashMap();
			root.put("content", content);
			template = FreemarkerUtil.getTemplate(temp);
			template.setEncoding(ENCODING);
			try {
				content = FreeMarkerTemplateUtils.processTemplateIntoString(
						template, root);
			} catch (TemplateException e) {
				log.error(
						"################### set template error #################",
						e);
			}
			// 标题
			if (mail.setSubject(subject) == false) {
				log.error("################### set mail title error #################");
				return false;
			}
			// 邮件内容 支持html 如欢迎你,java</font>
			if (mail.setBody(content) == false) {
				log.error("################### set mail content error#################");
				return false;
			}
			// 收件人邮箱
			if (mail.setTo(receiver) == false) {
				log.error("################### set mail receiver error#################");
				return false;
			}
			// 发件人邮箱
			if (mail.setFrom(from) == false) {
				log.error("################### set mail from error#################");
				return false;
			}
			// 设置附件
			// if(themail.addFileAffix("mail.txt") == false)
			// return; //附件在本地机子上的绝对路径
			mail.setNamePass(username, password); // 用户名与密码,即您选择一个自己的电邮
			if (mail.sendout() == false) {
				log.error("################### send mail error#################");
				return false;
			}
			log.debug("====================== Send Email Success!!!!=======================");
		} catch (IOException e) {
			log.error(e.toString(), e);
		}
		return true;
	}

}
