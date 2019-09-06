package com.ysc.afterschool.service;

import java.io.IOException;

import org.apache.commons.codec.binary.Base64;
import org.springframework.stereotype.Service;

import com.squareup.okhttp.MediaType;
import com.squareup.okhttp.OkHttpClient;
import com.squareup.okhttp.Request;
import com.squareup.okhttp.RequestBody;
import com.squareup.okhttp.Response;

@Service
public class SmsService {
	
	private final String key = "ysc2019:eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc21zLmdhYmlhLmNvbVwvIiwiYXVkIjoiXC9vYXV0aFwvdG9rZW4iLCJleHAiOjE1Njc2Nzg2MTYsImNyZWF0ZWRfYXQiOjE1Njc2NzUwMTYsInVzZXJfaWQiOiJ5c2MyMDE5IiwiY2xpZW50X2lwIjoiMTI1LjEzOC45MS4yMDcifQ.m6SLZBcvr13T26fZC35EYlANukG2w-OQPXalNQRDpYqmiLb7WFphjjFqDyuzuVHEnK7GMwcdEHOzwJwdSTD-LR-84V_zoAF5db3aKN30bagasj2GW1QhWahNk9UYf4fAp2G49eXzN4WeHMQcgsn4Tm6n1GNGS-LZC84ZH8X9sW6TrQ2r2v6rs07OfvMa-pfGttPoXufaefqObppczBCAQsyRw8lOfljWlYRrkc76xIsw07lR0f6PN_OrTcnlZqr7iTFoRojcHtkxea13d5kg7LroZHi87CAm6ip5RhnwL5kv0EozEktk6FUO-1m6e6qqJmhwHunH7z1VXyO2ydVE4Q";
	
	private final String message = "<캠퍼스형방과후학교>대기중인 과목의 수강신청이 승인되었습니다.";
	private final String callback = "0552870513";
	
	public void init() throws IOException {
		String text = "ysc2019:505e4c6d61dbe9dbf93e0f8861dc2c5d";
		byte[] encodedBytes = Base64.encodeBase64(text.getBytes());
		
		/* base64 decoding */ 
		//byte[] decodedBytes = Base64.decodeBase64(encodedBytes); 
		
		System.out.println("인코딩 전 : " + text); 
		System.out.println("인코딩 text : " + new String(encodedBytes));

		OkHttpClient client = new OkHttpClient();

		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		RequestBody body = RequestBody.create(mediaType, "grant_type=client_credentials");
		Request request = new Request.Builder()
		.url("https://sms.gabia.com/oauth/token")
		.post(body)
		.addHeader("Content-Type", "application/x-www-form-urlencoded")
		.addHeader("Authorization", "Basic " + new String(encodedBytes))
		.addHeader("cache-control", "no-cache")
		.build();

		Response response = client.newCall(request).execute();
		System.err.println("response : " + response.body().toString());
		System.err.println("response : " + response);
	}

	public void send(String phone) throws IOException {
		phone = phone.replaceAll("-", "");
		
		OkHttpClient client = new OkHttpClient();

		MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
		RequestBody body = RequestBody.create(mediaType, "phone=" + phone + "&callback=" + callback + "&message=" + message + "&refkey=12132214");
		Request request = new Request.Builder()
		.url("https://sms.gabia.com/api/send/sms")
		.post(body)
		.addHeader("Content-Type", "application/x-www-form-urlencoded")
		.addHeader("Authorization", "Basic " + new String(Base64.encodeBase64(key.getBytes())))
		.build();

		Response response = client.newCall(request).execute();
		System.err.println("response : " + response.toString());
	}
	
}
