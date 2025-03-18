console.log("calling")
$(document).ready(function(){
    console.log("like")
    $(".button").click(function(){
        var button = this;
        var post_id = button.value;
        var action = button.getAttribute('action');
        $.ajax({
            url: `/like_unlike`,
            type: 'GET',
            data: {
                post_id: post_id,
                action: action
            },
            success: function(response){
                console.log('like and unlike')
                console.log(response);
                console.log(response.count);
                console.log(response.action);
                button.nextElementSibling.outerHTML = `<span class="like p-1 cursor mr-2">${response.count} likes</span>`;
                if(response.action == 'like'){
                    button.className = 'fa fa-heart ml-1 btn btn-outline-danger';
                    button.setAttribute('action','unlike')
                    button.innerHTML = ' Unlike';
                }
                else{
                    button.className = 'fa fa-heart-o ml-1 btn btn-outline-primary';
                    button.setAttribute('action','like')
                    button.innerHTML = ' Like';
                }
            }
        });
    });
});