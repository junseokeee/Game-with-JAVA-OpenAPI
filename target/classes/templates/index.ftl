<!DOCTYPE html>
<html lang = "kr">
<head>
    <meta charset = "UTF-8">
    <meta http-equiv = "X-UA-Compatible" content = "IE=chrome">
    <meta name = "viewport" content = "width=device-width, initial-scale=1.0">
    <title>내가 그린 green 그림</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.5.0-beta4/html2canvas.min.js"></script>
</head>
<style>
    @font-face {
        font-family: 'SUITE-Regular';
        src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2304-2@1.0/SUITE-Regular.woff2') format('woff2');
        font-weight: 400;
        font-style: normal;
    }

    body {
        font-family: 'SUITE-Regular', sans-serif;
    }
    .menu {
        display: inline-block;
        white-space: nowrap;
        margin: 30px;
        cursor: pointer;
    }
    h2 {
        display: flex;
        justify-content: center;
        align-items: center;
        margin: 9px ;
    }

    .bar {
        width: 100%;
        max-width: 500px;
        margin: 0 auto;
        padding: 10px;
        border: 0;
        box-shadow: 0 2px 4px rgba(50, 50, 93, 0.1), 0 0 0 1px rgba(42, 47, 69, 0.16);
        border-radius: 5px;
        font-size: 14px;
        text-align: center;
    }

    .sketch img {
        width: 500px;
        height: 500px;
        background-color: white;
        border-radius: 15px;
        box-shadow: 0 4px 6px rgba(50, 50, 93, 0.11), 0 1px 3px rgba(0, 0, 0, 0.08);
    }

    .rectangle-container {
        display: grid;
        grid-template-columns: repeat(2, 1fr);
        grid-template-rows: repeat(4, 1fr);
        gap: 10px;
    }

    .rectangle {
        background-color: #ccc;
        border: 1px solid #000;
        height: 100%;
    }

    table {
        border-collapse: collapse;
        width: 10%;
    }

    table, th, td {
        border: 1px solid black;
    }
    #wordInput {
        resize: none;
        border: none;
    }
    .menu:hover {
        font-size: 20px;
        transition: font-size 0.3s ease;
    }
    .new-content {
        width: 300px;
        background-color: lightblue;
        padding: 10px;
        box-shadow: 0 2px 4px rgba(50, 50, 93, 0.1), 0 0 0 1px rgba(42, 47, 69, 0.16);
        border-radius: 5px;
        position: absolute;
        top: 0;
        right: 20px;
    }
    textarea:focus {
        outline: none;
    }
    .menu {
        white-space: nowrap;
        margin: 18px;
        cursor: pointer;
    }

    #customNotification {
        display: none;
        position: fixed;
        bottom: 20px;
        right: 20px;
        background-color: #fff;
        border: 1px solid #000;
        padding: 10px;
        box-shadow: 0 2px 4px rgba(50, 50, 93, 0.2), 0 0 0 1px rgba(42, 47, 69, 0.1);
        border-radius: 5px;
        z-index: 9999;
        /* Add animation properties */
        animation: fadeInOut 10s linear;
    }

    /* Define the animation keyframes */
    @keyframes fadeInOut {
        0% {
            opacity: 0;
            transform: scale(0.8);
        }
        50% {
            opacity: 1;
            transform: scale(1);
        }
        100% {
            opacity: 0;
            transform: scale(0.8);
        }
    }
    .swal-button-container {
        display: flex;
        justify-content: center;
    }
    .swal-button {
        flex: 1;
        border: none;
        border-radius: 0;
        font-size: 16px;
        padding: 10px 20px;
    }

    /* Style Yes button */
    .swal-button--confirm {
        background-color: #3085d6;
        color: white;
    }

    /* Style No button */
    .swal-button--cancel {
        background-color: #aaa;
        color: white;
    }

</style>
<body>
    <span>
        <div class = "bar">
            <div class="menu" onclick="takeScreenshot()">
                스크린샷
            </div>
            <div class = "menu" onclick="showAndRefresh()">
                다음문제
            </div>
            <div class = "menu" onclick="toggleFullScreen()">
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

            <div class="new-content">
                <h2>내가 그린 Green 그림</h2><br/>
                <p>이 게임은 Papago API와 Karlo API를 사용해 만들었습니다.</p>
                <p>이미지를 생성할 때 사용된 단어를 맞추는 게임입니다.</p>
                <p>3가지 단어를 사용해서 이미지를 생성했습니다.</p><br/>
                <p>백석대학교 컴퓨터공학부</p>
                <p>강병진, 김재성, 이준석</p>
            </div>

            <div id="customNotification" style="display: none;">그림 그리는 중...</div>
    </span>
    <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

    <script>
        var base64Incoding = "${base64Image}";
        var base64Image = base64Incoding;

        function decodeAndDisplayImage(base64Image) {

            var imageElement = document.createElement("img");
            imageElement.src = "data:image/png;base64," + base64Image;
            imageElement.width = 500;
            imageElement.height = 500;
            var sketchElement = document.querySelector(".sketch");
            sketchElement.appendChild(imageElement);
        }
        decodeAndDisplayImage(base64Image);

        function showAndRefresh() {
            var customNotification = document.getElementById('customNotification');
            customNotification.style.display = 'block';
            location.reload();
            setTimeout(function () {
                customNotification.style.display = 'none';

            }, 10000);
        }
        function takeScreenshot() {
            var sketchElement = document.querySelector(".sketch");
            html2canvas(sketchElement).then(function (canvas) {
                var screenshotUrl = canvas.toDataURL("image/png");
                var downloadLink = document.createElement("a");
                downloadLink.href = screenshotUrl;
                downloadLink.download = "screenshot.png";
                downloadLink.click();
            });
            swal('스크린샷을 저장했습니다.')
        }

        function toggleFullScreen() {
            var doc = window.document;
            var docEl = doc.documentElement;

            var requestFullScreen = docEl.requestFullscreen || docEl.mozRequestFullScreen || docEl.webkitRequestFullScreen || docEl.msRequestFullscreen;
            var cancelFullScreen = doc.exitFullscreen || doc.mozCancelFullScreen || doc.webkitExitFullscreen || doc.msExitFullscreen;

            if (!doc.fullscreenElement && !doc.mozFullScreenElement && !doc.webkitFullscreenElement && !doc.msFullscreenElement) {
                requestFullScreen.call(docEl);
            } else {
                cancelFullScreen.call(doc);
            }
        }
        window.addEventListener('load', function() {
            document.getElementById('wordInput').focus();
        });
        var baseWords;
        var randomWords;
        var wordElements = [];

        Promise.all([
            fetch('/karlo/array1').then(response => response.json()),
            fetch('/karlo/array2').then(response => response.json())
        ])
            .then(dataArray => {
                [baseWords, randomWords] = dataArray;

                shuffleArray(baseWords);

                var scoreElement = document.getElementById('example');
                scoreElement.textContent = '단어: ' + baseWords;


                randomWords.forEach((randomWords, index) => {
                    const wordElement = document.createElement('p');
                    wordElement.textContent = randomWords;
                    wordElements[index] = wordElement.textContent;
                    console.log(wordElements[index]);
                });
            })
            .catch(error => {
                console.error('Error:', error);
            });

        function shuffleArray(array) {
            for (let i = array.length - 1; i > 0; i--) {
                const j = Math.floor(Math.random() * (i + 1));
                [array[i], array[j]] = [array[j], array[i]];
            }
        }

        var totalCount = getCookieValue("totalCount") || 0;
        var scoreElement = document.getElementById('score');
        scoreElement.textContent = '정답:' + totalCount + '개';
        var expirationDate = new Date();
        expirationDate.setTime(expirationDate.getTime() + 10 * 60 * 1000);
        var expires = expirationDate.toUTCString();

        var remainTime = 60;

        const timer = setInterval(() => {
            remainTime--; // 1씩 감소

            // 카운트다운이 0보다 크면 갱신된 값을 출력
            if (remainTime >= 0) {
                var timeElement = document.getElementById('time');
                timeElement.textContent = '남은시간:' + remainTime + '초';
            }

            // 카운트다운이 0이 되면 타이머 종료
            if (remainTime === 0) {
                clearInterval(timer);
                swal("게임 종료");
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

        function decodeBase64Image(base64Image) {
            var base64ImageContent = base64Image.replace(/^data:image\/(png|jpeg|jpg);base64,/, '');
            var img = new Image();
            img.src = 'data:image/png;base64,' + base64ImageContent;
            return img;
        }
        function setDecodedImageAsBackground(base64Image, targetElement) {
            var base64ImageContent = base64Image.replace(/^data:image\/(png|jpeg|jpg);base64,/, '');

            var imageUrl = 'data:image/png;base64,' + base64ImageContent;

            targetElement.style.backgroundImage = 'url(' + imageUrl + ')';
        }

        function getCookieValue(cookieName) {
            var cookies = document.cookie.split(';');
            for (var i = 0; i < cookies.length; i++) {
                var cookie = cookies[i].trim();
                if (cookie.startsWith(cookieName + "=")) {
                    return parseInt(cookie.substring(cookieName.length + 1), 10);
                }
            }
            return null;
        }

        function updateTotalCount(totalCount) {
            document.cookie = "totalCount=" + totalCount + "; expires=" + expires + "; path=/";
        }

        function processInput() {
            const wordInput = document.getElementById("wordInput");
            const inputText = wordInput.value;
            const wordsArr = inputText.split(' ').map(resultText => resultText.trim());

            if (wordsArr.length !== 3) {
                swal({
                    title: '단어 개수가 맞지 않습니다.',
                    text: '정확히 3개의 단어만 입력해주세요.',
                    icon: 'warning',
                    customClass: 'centered-swal-button',
                })
                return;
            }

            const result = wordsArr;
            console.log(result[0]);
            console.log(result[1]);
            console.log(result[2]);

            if (result.length > 3) {
                swal({
                    title: '단어 개수가 너무 많습니다.',
                    text: '3개의 단어만 입력해주세요.',
                    icon: 'warning',
                    customClass: 'centered-swal-button',
                })
                return;
            }

            let correctCount = 0;
            wordElements.forEach(word2 => {
                const trimmedWord = word2.replace(/\s/g, '');
                if (result.includes(trimmedWord)) {
                    correctCount++;
                }
            });

            // 정답 개수에 따라 출력
            if (correctCount === 3) {
                swal({
                    title: '정답입니다',
                    text: 'OK 버튼을 누르면 다음 그림을 만들어요.',
                    icon: 'success',
                    customClass: 'centered-swal-button',
                });
                totalCount ++;
                updateTotalCount(totalCount);
                scoreElement = document.getElementById('score');
                scoreElement.textContent = '정답:' + totalCount + '개';
                location.reload();

            } else if (correctCount === 2) {
                swal("입력한 단어 " + result[0] + ", " + result[1] + ", " + result[2] + " 중 2개를 맞췄습니다.");
            } else if (correctCount === 1) {
                swal("입력한 단어 " + result[0] + ", " + result[1] + ", " + result[2] + " 중 1개를 맞췄습니다.");
            } else {
                swal("단어 3개를 맞추지 못했습니다.");
            }
        }

        function exit() {
            swal({
                title: "게임 종료",
                text: "게임을 종료하시겠습니까?",
                icon: "warning",
                customClass: 'swal-button-container',
                buttons: {
                    yes: "예",
                    no: "아니오",
                },
            }).then((value) => {
                if (value === "yes") {
                    window.location.href = "gate.html";
                } else {
                    // Code to stay on the current page or perform any other action
                }
            });
        }
    </script>
</body>
</html>