package com.ysc.afterschool.service.common;

import java.io.IOException;

import org.apache.commons.codec.binary.Base64;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.stereotype.Service;

import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;
import com.squareup.okhttp.internal.http.RealResponseBody;

import lombok.extern.slf4j.Slf4j;

/**
 * 가비아 문자 API 연동 서비스
 * 
 * @author hgko
 *
 */
@Slf4j
@Service
public class SmsService {
	
	private String tokenType;
	private String token;
	
	private final String message = "<캠퍼스형방과후학교> 학부모교육장입장불가, 개별마스크반드시착용, 수업10분전도착";
//	private final String callback = "0552740518"; //0552870513, 창원
	private final String callback = "0557930159"; //진주
	
	public void init() throws IOException {
		String text = "ysc2019:505e4c6d61dbe9dbf93e0f8861dc2c5d";
		byte[] encodedBytes = Base64.encodeBase64(text.getBytes());
		
		/* base64 decoding */ 
		//byte[] decodedBytes = Base64.decodeBase64(encodedBytes);
//		System.out.println("인코딩 전 : " + text); 
//		System.out.println("인코딩 text : " + new String(encodedBytes));

		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		RequestBody body = RequestBody.create(mediaType, "grant_type=client_credentials");
		Request request = new Request.Builder()
		.url("https://sms.gabia.com/oauth/token")
		.post(body)
		.addHeader("Content-Type", "application/x-www-form-urlencoded")
		.addHeader("Authorization", "Basic " + new String(encodedBytes))
		.addHeader("cache-control", "no-cache")
		.build();
		
		OkHttpClient client = new OkHttpClient();
		Response response = client.newCall(request).execute();
		log.debug("init response : " + response.toString());
		if (response.isSuccessful()) {
			RealResponseBody result = (RealResponseBody) response.body();
			try {
				JSONParser jsonParser = new JSONParser();
				JSONObject jsonObject = (JSONObject) jsonParser.parse(result.string());
				
				String accessToken = (String) jsonObject.get("access_token");
				tokenType = (String) jsonObject.get("token_type");
				token = "ysc2019:" + accessToken;
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			result.close();
		}
	}

	/**
	 * 메시지 전송
	 * @param phone
	 * @throws IOException
	 */
	public void send(String phone) throws IOException {
		init();
		
		phone = phone.replaceAll("-", "");
		
		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		RequestBody body = RequestBody.create(mediaType, "phone=" + phone + "&callback=" + callback + "&message=" + message + "&refkey=12132214");
		Request request = new Request.Builder()
			.url("https://sms.gabia.com/api/send/sms")
			.post(body)
			.addHeader("Content-Type", "application/x-www-form-urlencoded")
			.addHeader("Authorization", tokenType + " " + new String(Base64.encodeBase64(token.getBytes())))
			.addHeader("cache-control", "no-cache")
			.build();

		OkHttpClient client = new OkHttpClient();
		Response response = client.newCall(request).execute();
		response.body().close();
		log.debug("send response : " + response.toString());
	}
	
}
