// 주어진 배열에서 랜덤하게 n개의 요소를 선택하는 함수
function getRandomElementsFromArray(arr, n) {
    const shuffled = arr.slice(); // 배열을 복사하여 셔플을 위한 작업을 수행합니다.
    let i = arr.length;
    let temp, randomIdx;

    while (i--) {
      randomIdx = Math.floor((i + 1) * Math.random()); // 0부터 i까지의 랜덤한 인덱스를 생성합니다.
      temp = shuffled[randomIdx]; // 현재 요소와 랜덤하게 선택된 요소를 교환합니다.
      shuffled[randomIdx] = shuffled[i];
      shuffled[i] = temp;
    }

    return shuffled.slice(0, n); // 앞에서부터 n개의 요소를 반환합니다.
  }

  // 파일을 읽어와서 단어 배열로 변환하는 함수
  function readWordsFromFile(filePath) {
    const fileContent = getFileContent(filePath);
    const words = fileContent.split(',');

    return words;
  }

  // 파일에서 텍스트 내용을 가져오는 함수
  function getFileContent(filePath) {
    const xmlhttp = new XMLHttpRequest();
    xmlhttp.open('GET', filePath, false);
    xmlhttp.send();
    
    return xmlhttp.responseText;
  }

  // 파일 경로
  const filePath = 'words.txt';

  // 파일로부터 단어를 읽어옵니다.
  const words = readWordsFromFile(filePath);

  // 10개의 랜덤한 단어를 선택합니다.
  const baseWords = getRandomElementsFromArray(words, 10);
  var scoreElement = document.getElementById('example');
  scoreElement.textContent = `단어: ${baseWords}`;

  const randomWords = getRandomElementsFromArray(baseWords, 3);

  var wordElements = [];
  // 선택된 단어를 출력합니다.
  randomWords.forEach((word, index) => {
    const wordElement = document.createElement('p');
    wordElement.textContent = word;
    wordElements[index] = wordElement.textContent;
    console.log(wordElements[index]);
  });

  var totalCount = 0;
  var scoreElement = document.getElementById('score');
  scoreElement.textContent = `정답: ${totalCount}개`;

  var remainTime = 60;
  
  const timer = setInterval(() => {
    remainTime--; // 1씩 감소
  
    // 카운트다운이 0보다 크면 갱신된 값을 출력
    if (remainTime >= 0) {
      var timeElement = document.getElementById('time');
      timeElement.textContent = `남은시간: ${remainTime}초`;
    }
  
    // 카운트다운이 0이 되면 타이머 종료
    if (remainTime === 0) {
      clearInterval(timer);
      alert("게임 종료");
      window.location.href = 'gate.html';
    }
  }, 1000);

  function handleKeyDown(event) {
    if (event.keyCode === 13) {
        event.preventDefault();
        document.getElementById("submitButton").click();
        const textarea = document.getElementById("wordInput");
        textarea.value = '';
    }
  }
  // Access the base64Image variable passed from Java
  console.log('Base64 image:', base64Image);

  // Function to decode base64 image and create an image element
  function decodeBase64Image(base64Image) {
    // Remove data URL prefix
    var base64ImageContent = base64Image.replace(/^data:image\/(png|jpeg|jpg);base64,/, '');

    // Create an empty image element
    var img = new Image();

    // Set the source of the image as the decoded base64 content
    img.src = 'data:image/png;base64,' + base64ImageContent;

    // Return the decoded image element
    return img;
  }
function setDecodedImageAsBackground(base64Image, targetElement) {
  // Remove data URL prefix
  var base64ImageContent = base64Image.replace(/^data:image\/(png|jpeg|jpg);base64,/, '');

  // Create CSS background image URL with the decoded base64 content
  var imageUrl = 'data:image/png;base64,' + base64ImageContent;

  // Set the background image of the target element
  targetElement.style.backgroundImage = 'url(' + imageUrl + ')';
}



  function processInput() {
    const wordInput = document.getElementById("wordInput");
    const inputText = wordInput.value;
    const wordsArr = inputText.split(' ').map(resultText => resultText.trim());
    
    const result = [];
    result[0] = wordsArr[0];
    result[1] = wordsArr[1];
    result[2] = wordsArr[2];

    console.log(result[0]);
    console.log(result[1]);
    console.log(result[2]);

    let correctCount = 0;
    wordElements.forEach(word2 => {
      const trimmedWord = word2.replace(/\s/g, '');
      if (result.includes(trimmedWord)) {
        correctCount++;
      }
    });

    // 정답 개수에 따라 출력
    if (correctCount === 3) {
      console.log("정답입니다!");
      totalCount ++;
      scoreElement = document.getElementById('score');
      scoreElement.textContent = `정답: ${totalCount}개`;

      remainTime = 60;

      // Write the JavaScript code here
      // Place the provided code snippet inside this <script> tag
      // It should be placed after the other included JavaScript files
      // and before the closing </body> tag

      // 이미지 요소 생성 및 추가하는 코드
//      var imageElement = document.createElement("img");
//      var imagePath = "/Users/gimjaeseong/IdeaProjects/one/decoded_image.jpeg"; // 이미지 파일의 경로와 파일 이름을 적절히 변경해야 합니다.
//      imageElement.src = imagePath;
//      var sketchElement = document.querySelector(".sketch");
//      sketchElement.appendChild(imageElement);
 // Decode the base64 image and create an image element
//  var decodedImage = decodeBase64Image(base64Image);
//
//  // Once the image is loaded, you can access its properties and perform further actions
//  decodedImage.onload = function() {
//    console.log('Decoded image width:', decodedImage.width);
//    console.log('Decoded image height:', decodedImage.height);
//
//    // Check if the image size matches the specified size (1024x1024)
//    if (decodedImage.width === 1024 && decodedImage.height === 1024) {
//      console.log('Image size is 1024x1024. Proceed with further actions.');
//
//      // Further actions with the decoded image
//      // ...
//    } else {
//      console.log('Image size is not 1024x1024. Please check the image dimensions.');
//    }
//  };
//  // Find the target element by its class name
//  var sketchElement = document.querySelector('.sketch');
//
//  // Decode the base64 image and set it as the background of the target element
//  setDecodedImageAsBackground(base64Image, sketchElement);

      const baseWords = getRandomElementsFromArray(words, 10);
      scoreElement = document.getElementById('example');
      scoreElement.textContent = `단어: ${baseWords}`;

      const randomWords = getRandomElementsFromArray(baseWords, 3);

      // 선택된 단어를 출력합니다.
      randomWords.forEach((word, index) => {
        const wordElement = document.createElement('p');
        wordElement.textContent = word;
        wordElements[index] = wordElement.textContent;
        console.log(wordElements[index]);
      });

    } else if (correctCount === 2) {
      console.log("2개를 맞췄습니다.");
    } else if (correctCount === 1) {
      console.log("1개를 맞췄습니다.");
    } else {
      console.log("단어 3개를 맞추지 못했습니다.");
    }
  };
