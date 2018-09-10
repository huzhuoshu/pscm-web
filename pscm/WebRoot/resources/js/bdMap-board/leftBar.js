$('#leftbar-trigger').click(function () {
    let opened = $('#leftbar-trigger-icon').hasClass('glyphicon-menu-left');
    let menuLeft = 'glyphicon-menu-left', menuRight = 'glyphicon-menu-right';
    $('#leftbar').stop().animate({left: opened ? "-300px" : "0px"}, 500);
    $('#leftbar-trigger-icon').removeClass(opened ? menuLeft : menuRight);
    $('#leftbar-trigger-icon').addClass(opened ? menuRight : menuLeft);
});

function openLeftBar() {
    let opened = $('#leftbar-trigger-icon').hasClass('glyphicon-menu-left');
    if(!opened) $('#leftbar-trigger').click();
}