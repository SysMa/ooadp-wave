function checkImgCss(o, img) {
    if (!/\.((jpg)|(bmp)|(gif)|(png))$/ig.test(o.value)) {
        alert('只能上传jpg,bmp,gif,png格式图片!');
        o.outerHTML = o.outerHTML;
    }
    else {
        if (document.getElementById("avater_pic") !== null) {
            document.getElementById(img).removeChild(document.getElementById("avater_pic"));
        }
        document.getElementById(img).filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = o.value;
    }
}
function displayImage(container, dataURL) {
    if (document.getElementById("avater_pic") !== null) {
        container.removeChild(document.getElementById("avater_pic"));
    }
    var img = document.createElement('img');
    img.src = dataURL;
    img.setAttribute("id", "avater_pic");
    img.setAttribute("style", "width:100px;height:100px");
    container.appendChild(img);
}
function handleFiles(files, label) {
    for (var i = 0; i < files.length; i++) {
        var file = files[i];
        var imageType = /image.*/;

        if (!file.type.match(imageType)) {
            continue;
        }

        var reader = new FileReader();
        reader.onload = function (e) {
            displayImage(document.getElementById(label), e.target.result);
        }
        reader.readAsDataURL(file);
    }
}
function showAvater(o, label) {
    if (navigator.userAgent.indexOf("MSIE") > 0) {
        checkImgCss(o, label);
    }
    else {
        handleFiles(o.files, label);
    }
}