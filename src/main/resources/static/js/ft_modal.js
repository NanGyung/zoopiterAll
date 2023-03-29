
const $ftItem1 = document.getElementById('ftItem1');
const $ftItem2 = document.getElementById('ftItem2');
const $ftItem3 = document.getElementById('ftItem3');
const $infoWindow1 = document.getElementById('ft-info1');
const $infoWindow2 = document.getElementById('ft-info2');
const $infoWindow3 = document.getElementById('ft-info3');
const $closeBtn1 = document.getElementById('closeBtn1');
const $closeBtn2 = document.getElementById('closeBtn2');
const $closeBtn3 = document.getElementById('closeBtn3');

$ftItem1.addEventListener('click', e => $infoWindow1.showModal(), false);
$ftItem2.addEventListener('click', e => $infoWindow2.showModal(), false);
$ftItem3.addEventListener('click', e => $infoWindow3.showModal(), false);

$closeBtn1.addEventListener('click', e => $infoWindow1.close(), false);
$closeBtn2.addEventListener('click', e => $infoWindow2.close(), false);
$closeBtn3.addEventListener('click', e => $infoWindow3.close(), false);