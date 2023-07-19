<!DOCTYPE html>
<html lang = "kr">
<head>
    <meta charset = "UTF-8">
    <meta http-equiv = "X-UA-Compatible" content = "IE=chrome">
    <meta name = "viewport" content = "width=device-width, initial-scale=1.0">
    <title>내가 그린 green 그림</title>
    <link rel = "stylesheet" href = "styles.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
    <span>
        내가 그린<br>
        green 그림
        <div class = "bar">
            <div class = "menu">
                스크린샷
            </div>
            <div class = "menu">
                초대하기
            </div>
            <div class = "menu">
                전체화면
            </div>
            <div class = "menu" onclick="exit()">
                종료하기
            </div>
        </div>
        <div>
            <div class = "bar">
                <div class = "sketch"></div>
            </div>
        </div>
            <div class = "bar" id = "example"></div>
            <div class = "bar" id = "time"></div>
            <div class = "bar" id = "score"></div>
            <div class = "bar">
                <textarea id = "wordInput" onkeydown = "handleKeyDown(event)"></textarea>
                <button id = "submitButton" onclick = "processInput()" type = "button" hidden>확인</button>
            </div>
    </span>
    <script>
    var base64Incoding = "${base64Image}";
    // Base64 encoded image string
    var base64Image = base64Incoding;

    // Function to decode base64 image and display it
    function decodeAndDisplayImage(base64Image) {
      // Create an image element
      var imageElement = document.createElement("img");

      // Set the image source as the decoded base64 string
      imageElement.src = "data:image/png;base64," + base64Image;

      // Set the image dimensions
      imageElement.width = 500;
      imageElement.height = 500;

      // Find the sketch element
      var sketchElement = document.querySelector(".sketch");

      // Append the image element to the sketch element
      sketchElement.appendChild(imageElement);
    }

    // Call the function to decode and display the image
    decodeAndDisplayImage(base64Image);

    console.log(base64Incoding);
    </script>
    <script src = "createUser.js"></script>
    <script src = "randomWords.js"></script>
    <script src = "button.js"></script>

</body>
</html>