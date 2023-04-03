//지역 검색 모달 실험
document.getElementById("areaSelectOpen").onclick = function() {
    document.getElementById("areaModal").style.display="block";
}
document.getElementById("areaSelectClose").onclick = function() {
    document.getElementById("areaModal").style.display="none";
}
$("#areaSelectOpen").click(function(){
    $("#areaModal").attr("style", "display:block");
});

 $("#areaSelectClose").click(function(){
    $("#areaModal").attr("style", "display:none");
});     



