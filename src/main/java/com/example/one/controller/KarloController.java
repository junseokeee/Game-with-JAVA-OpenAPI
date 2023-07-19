package com.example.one.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.*;
import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.json.JSONArray;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class KarloController {
    private static String[] translations;
    private static String[] array1;
    private static String[] array2;
    @GetMapping("/karlo")
    public ModelAndView processKarloRequest() {
        String clientId = "tQY6J2hzpaCmNYGDb6_o"; // 애플리케이션 클라이언트 아이디값
        String clientSecret = "_lnXf8BL9d"; // 애플리케이션 클라이언트 시크릿값
        String[] names = {"고양이", "개", "사자", "호랑이", "곰", "코끼리", "기린", "원숭이", "판다", "양", "침팬지", "뱀", "캥거루", "얼룩말", "고릴라", "오랑우탄", "악어", "펭귄", "사슴", "돌고래", "치타", "물범", "순록", "산", "바다", "호수", "하늘", "폭포", "초원", "섬", "해변", "숲", "바람", "구름", "달", "별", "태양", "무지개", "얼음", "바람력", "사막", "벌판", "축구", "농구", "야구", "수영", "달리기", "테니스", "골프", "볼링", "요가", "배드민턴", "체조", "스케이팅", "헬스", "승마", "서핑", "스노우보드", "클라이밍", "스쿼시"};
        String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
        

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);

        array1 = getRandomWords(names, 10);

        array2 = getRandomWords(array1, 3);

        int[] selectedIndices = getIndices(array1, array2);

        translations = new String[3]; // Array to store translations

        for (int i = 0; i < selectedIndices.length; i++) {
            int index = selectedIndices[i];
            String text;
            try {
                text = URLEncoder.encode(array2[i], "UTF-8");
            } catch (UnsupportedEncodingException e) {
                throw new RuntimeException("인코딩 실패", e);
            }

            String translatedText = post(apiURL, requestHeaders, text);
            String extractedTranslation = extractTranslatedText(translatedText);
            translations[i] = extractedTranslation;
        }

        // Print the translations
        for (String translation : translations) {
            System.out.println(translation);
        }
        String REST_API_KEY = "1163c85204e2d09b879b325db62a5bff";
        // Generate three random words

        Map<String, Object> jsonMap = new HashMap<>();
        jsonMap.put("prompt", String.join("masterpiece"+" ", translations));
        jsonMap.put("samples", 1);
        jsonMap.put("return_type", "base64_string");
        jsonMap.put("image_quality", 100);

        String json = new JSONObject(jsonMap).toString();

        HttpHeaders headers = new HttpHeaders();
        headers.set(HttpHeaders.AUTHORIZATION, "KakaoAK " + REST_API_KEY);
        headers.setContentType(MediaType.APPLICATION_JSON);

        HttpEntity<Map<String, Object>> httpEntity = new HttpEntity<>(jsonMap, headers);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange("https://api.kakaobrain.com/v2/inference/karlo/t2i", HttpMethod.POST, httpEntity, String.class);
        String base64Image = "";
        if (response.getStatusCode().is2xxSuccessful()) {
            String responseBody = response.getBody();

            JSONObject jsonResponse = new JSONObject(responseBody);
            base64Image = jsonResponse.getJSONArray("images")
                    .getJSONObject(0)
                    .getString("image");
        }

        Map<String, Object> maps = new HashMap<>();
        maps.put("base64Image", base64Image);
        maps.put("array1", array1);
        maps.put("array2", array2);

        return new ModelAndView("index", maps);
    }

    private String[] getRandomWords(String[] array, int count) {
        Random random = new Random();
        List<String> wordList = Arrays.asList(array);
        Collections.shuffle(wordList);
        return wordList.subList(0, count).toArray(new String[0]);
    }

    // 배열에서 특정 단어의 인덱스 값을 추출하는 메소드
    private int[] getIndices(String[] array, String[] words) {
        int[] indices = new int[words.length];
        for (int i = 0; i < words.length; i++) {
            indices[i] = Arrays.asList(array).indexOf(words[i]);
        }
        return indices;
    }
    private static String post(String apiUrl, Map<String, String> requestHeaders, String text) {
        HttpURLConnection con = connect(apiUrl);
        String postParams = "source=ko&target=en&text=" + text;
        try {
            con.setRequestMethod("POST");
            for (Map.Entry<String, String> header : requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }

            con.setDoOutput(true);
            try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
                wr.write(postParams.getBytes());
                wr.flush();
            }

            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                return readBody(con.getInputStream());
            } else {
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }

    private static HttpURLConnection connect(String apiUrl) {
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection) url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }

    private static String readBody(InputStream body) {
        InputStreamReader streamReader = new InputStreamReader(body);

        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();

            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }

            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는데 실패했습니다.", e);
        }
    }

    private static String extractTranslatedText(String responseBody) {
        // Parse the JSON response to extract the translatedText
        // You can use a JSON parsing library like Gson or Jackson for a more robust implementation
        int startIndex = responseBody.indexOf("translatedText\":\"") + 17;
        int endIndex = responseBody.indexOf("\",\"engineType");
        return responseBody.substring(startIndex, endIndex);
    }

    @GetMapping("/karlo/array1")
    @ResponseBody
    public String getArray1() {
        JSONArray jsonArray1 = new JSONArray(Arrays.asList(array1));
        return jsonArray1.toString();
    }

    @GetMapping("/karlo/array2")
    @ResponseBody
    public String getArray2() {
        JSONArray jsonArray2 = new JSONArray(Arrays.asList(array2));
        return jsonArray2.toString();
    }

}