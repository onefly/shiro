package com.hxhk.util.encrypt;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;

import org.apache.log4j.Logger;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class AesUtil {
	private static String KEY = null;
	protected static Logger log4j = Logger.getLogger("AesUtil");	
	
	private static String readFileByChars(String fileName){
		StringBuffer result = new StringBuffer();
		File file = new File(fileName);
		Reader reader = null;
		try {		
			// 一次读一个字符
			reader = new InputStreamReader(new FileInputStream(file));
			int tempchar;
			while ((tempchar = reader.read()) != -1) {
				// 对于windows下，\r\n这两个字符在一起时，表示一个换行。
				// 但如果这两个字符分开显示时，会换两次行。
				// 因此，屏蔽掉\r，或者屏蔽\n。否则，将会多出很多空行。
				if (((char) tempchar) != '\r') {
					//System.out.print((char) tempchar);
					result.append((char) tempchar);
				}
			}
			reader.close();

		} catch (Exception e) {
			log4j.error(e.toString(), e);
		}
		return result.toString();
	}
	private final static String encoding = "UTF-8"; 
	/**
	 * AES加密
	 * 
	 * @param content
	 * @param password
	 * @return
	 */
	public static String encrypt(String content, String password) {
		byte[] encryptResult = encryptAes(content, password);
		String encryptResultStr = parseByte2HexStr(encryptResult);
		// BASE64位加密
		encryptResultStr = ebotongEncrypto(encryptResultStr);
		return encryptResultStr;
	}

	/**
	 * AES解密
	 * 
	 * @param encryptResultStr
	 * @param password
	 * @return
	 */
	public static String decrypt(String encryptResultStr, String password) {
		// BASE64位解密
		String decrpt = ebotongDecrypto(encryptResultStr);
		byte[] decryptFrom = parseHexStr2Byte(decrpt);
		byte[] decryptResult = decrypt(decryptFrom, password);
		return new String(decryptResult);
	}

		/**
	 * 加密字符串
	 */
	public static String ebotongEncrypto(String str) {
		BASE64Encoder base64encoder = new BASE64Encoder();
		String result = str;
		if (str != null && str.length() > 0) {
			try {
				byte[] encodeByte = str.getBytes(encoding);
				result = base64encoder.encode(encodeByte);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//base64加密超过一定长度会自动换行 需要去除换行符
		return result.replaceAll("\r\n", "").replaceAll("\r", "").replaceAll("\n", "");
	}

	/**
	 * 解密字符串
	 */
	public static String ebotongDecrypto(String str) {
		BASE64Decoder base64decoder = new BASE64Decoder();
		try {
			byte[] encodeByte = base64decoder.decodeBuffer(str);
			return new String(encodeByte);
		} catch (IOException e) {
			log4j.error(e.toString(), e);
			return str;
		}
	}
	/**  
	 * 加密  
	 *   
	 * @param content 需要加密的内容  
	 * @param password  加密密码  
	 * @return  
	 */  
	private static byte[] encryptAes(String content, String password) {   
	        try {              
	                KeyGenerator kgen = KeyGenerator.getInstance("AES"); 
	                //防止linux下 随机生成key
	                SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" );   
	                secureRandom.setSeed(password.getBytes());   
	                kgen.init(128, secureRandom);
	                //kgen.init(128, new SecureRandom(password.getBytes()));   
	                SecretKey secretKey = kgen.generateKey();   
	                byte[] enCodeFormat = secretKey.getEncoded();   
	                SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");   
	                Cipher cipher = Cipher.getInstance("AES");// 创建密码器   
	                byte[] byteContent = content.getBytes("utf-8");   
	                cipher.init(Cipher.ENCRYPT_MODE, key);// 初始化   
	                byte[] result = cipher.doFinal(byteContent);   
	                return result; // 加密   
	        } catch (NoSuchAlgorithmException e) {   
	        	log4j.error(e.toString(), e); 
	        } catch (NoSuchPaddingException e) {   
	        	log4j.error(e.toString(), e);  
	        } catch (InvalidKeyException e) {   
	        	log4j.error(e.toString(), e);  
	        } catch (UnsupportedEncodingException e) {   
	        	log4j.error(e.toString(), e);
	        } catch (IllegalBlockSizeException e) {   
	        	log4j.error(e.toString(), e);
	        } catch (BadPaddingException e) {   
	        	log4j.error(e.toString(), e);  
	        }   
	        return null;   
	}  


	/**解密  
	 * @param content  待解密内容  
	 * @param password 解密密钥  
	 * @return  
	 */  
	private static byte[] decrypt(byte[] content, String password) {   
	        try {   
	                 KeyGenerator kgen = KeyGenerator.getInstance("AES"); 
	               //防止linux下 随机生成key
		             SecureRandom secureRandom = SecureRandom.getInstance("SHA1PRNG" );   
		             secureRandom.setSeed(password.getBytes());   
		             kgen.init(128, secureRandom);
	                 //kgen.init(128, new SecureRandom(password.getBytes()));   
	                 SecretKey secretKey = kgen.generateKey();   
	                 byte[] enCodeFormat = secretKey.getEncoded();   
	                 SecretKeySpec key = new SecretKeySpec(enCodeFormat, "AES");               
	                 Cipher cipher = Cipher.getInstance("AES");// 创建密码器   
	                cipher.init(Cipher.DECRYPT_MODE, key);// 初始化   
	                byte[] result = cipher.doFinal(content);   
	                return result; // 加密   
	        } catch (NoSuchAlgorithmException e) {   
	        	log4j.error(e.toString(), e);
	        } catch (NoSuchPaddingException e) {   
	        	log4j.error(e.toString(), e);
	        } catch (InvalidKeyException e) {   
	        	log4j.error(e.toString(), e);
	        } catch (IllegalBlockSizeException e) {   
	        	log4j.error(e.toString(), e);
	        } catch (BadPaddingException e) {   
	        	log4j.error(e.toString(), e);
	        }   
	        return null;   
	}  

	/**将二进制转换成16进制  
	 * @param buf  
	 * @return  
	 */  
	public static String parseByte2HexStr(byte buf[]) {   
	        StringBuffer sb = new StringBuffer();   
	        for (int i = 0; i < buf.length; i++) {   
	                String hex = Integer.toHexString(buf[i] & 0xFF);   
	                if (hex.length() == 1) {   
	                        hex = '0' + hex;   
	                }   
	                sb.append(hex.toUpperCase());   
	        }   
	        return sb.toString();   
	}  


	/**将16进制转换为二进制  
	 * @param hexStr  
	 * @return  
	 */  
	public static byte[] parseHexStr2Byte(String hexStr) {   
	        if (hexStr.length() < 1)   
	                return null;   
	        byte[] result = new byte[hexStr.length()/2];   
	        for (int i = 0;i< hexStr.length()/2; i++) {   
	                int high = Integer.parseInt(hexStr.substring(i*2, i*2+1), 16);   
	                int low = Integer.parseInt(hexStr.substring(i*2+1, i*2+2), 16);   
	                result[i] = (byte) (high * 16 + low);   
	        }   
	        return result;   
	}  

	/**
	 * 默认加密方法
	 * 
	 * @param content
	 * @return
	 */
	public static String defaultEncrpt(String content) {
		return encrypt(content, KEY);
	}

	/**
	 * 默认解密方法
	 * 
	 * @param content
	 * @return
	 */
	public static String defaultDecrpt(String encryptResult) {
		return decrypt(encryptResult, KEY);
	}

	public static void main(String[] args) throws Exception {
		String pass = "qasdfjklajsdfkljsd;lfjskd;jfsdl;jfwiojfsnsd sdvsdjfiowesdfisdojfosdjfwjfsdjf sjkdjfweja.z.v//q;134549**7$%##@sdfjw";			
		// 解密
		String content = "U2FsdGVkX18FLJXA0cF7kS6ifE82E206MIHc7+FKvE8=";
		String text = encrypt(content,pass);		
		System.out.println("text:"+text);
		System.out.println(decrypt(text,pass));
		

	}
}
