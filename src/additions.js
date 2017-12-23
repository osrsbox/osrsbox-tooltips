$(document).ready(function(){

    $( document ).tooltip(); // initialize tooltip

    $( ".tooltip" ).tooltip({
        track:true,
        open: function( event, ui ) {
              var item_id = this.id;
              var category = item_id.charAt(0);
              var base_url = "http://osrsbox.com/osrsbox-db/items-json/"
              var fname = base_url + item_id + ".json"
              
              $.ajax({
                  type:'get',
                  url:fname,
                  dataType:'json',
                  success: successFunction,
                  error: errorFunction
              });
        }
    });

    $(".tooltip").mouseout(function(){
        // re-initializing tooltip
        $(this).attr('title','Please wait...');
        $(this).tooltip();
        $('.ui-tooltip').hide();
    });   
});

function successFunction(data) {
    var theContent = ""

    // Reusable variables
    var left = "<span class='item_left'>";
    var right = "<span class='item_right'>";
    var endSpan = "</span>";
    var aBreak = "<br/>";
    var clear = "<div class='osrs-tooltip-clear'></div>";

    // Construct tooltip header (item image and name)
    var id = data["id"].toString()
    var category = id.charAt(0);
    var img_url = "http://osrsbox.com/osrsbox-db/items-icons/" + data["id"] + ".png";
    var name = data['name'];
    var header = "<span class='osrs-tooltip-image'><img src=" + img_url + " alt=" + name + "></span><span class='osrs-tooltip-name'>" + name + "</span><br/>";

    // Construct tooltip content: item properties
    var properties = "<span class='osrs-tooltip-textleft'>Members Item : </span><span class='osrs-tooltip-textright'>" + boolToString(data['members_only']) + "</span><br/>" + "<span class='osrs-tooltip-textleft'>Quest Item : </span><span class='osrs-tooltip-textright'>" + boolToString(data['quest_item']) + "</span><br/>" + "<span class='osrs-tooltip-textleft'>Stackable : </span><span class='osrs-tooltip-textright'>" + boolToString(data['stackable']) + "</span><br/>" + "<span class='osrs-tooltip-textleft'>Equipable : </span><span class='osrs-tooltip-textright'>" + boolToString(data['equipable']) + "</span><br/>" + "<span class='osrs-tooltip-textleft'>Tradeable : </span><span class='osrs-tooltip-textright'>" + boolToString(data['tradeable']) + "</span><br/>" + "<span class='osrs-tooltip-textleft'>High Alchemy : </span><span class='osrs-tooltip-textright'>" +  data["highalch"] + "</span><br/>" + "<span class='osrs-tooltip-textleft'>Low Alchemy : </span><span class='osrs-tooltip-textright'>" + data["lowalch"] + "</span><br/>";

    if (data['equipable'] == false) {
        theContent = "<div>" + header + clear + properties + clear + "</div>";
        $("#" + data["id"]).tooltip('option', 'content', theContent);
        return
    }    
    
    var attack = "<span class='textleft'>Stab : </span><span class='textright'>" +  data["bonuses"]["attack_stab"] + "</span><br/>" + "<span class='textleft'>Slash : </span><span class='textright'>" +  data["bonuses"]["attack_slash"] + "</span><br/>" + "<span class='textleft'>Crush : </span><span class='textright'>" + data["bonuses"]["attack_crush"] + "</span><br/>" + "<span class='textleft'>Magic : </span><span class='textright'>" + data["bonuses"]['attack_magic'] + "</span><br/>" + "<span class='textleft'>Ranged : </span><span class='textright'>" + data["bonuses"]['attack_ranged'] + "</span><br/>"

    var attack_table = "<table class='osrs-tooltip-table'><tr><th colspan='5'>Attack Bonus</th></tr><tr><td><img src='http://osrsbox.com/osrsbox-tooltips/images/stab.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/slash.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/crush.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/magic.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/ranged.png' alt=''></td></tr><tr><td>" + data["bonuses"]['attack_stab'] + "</td>" + "<td>" + data["bonuses"]['attack_slash'] + "</td>" + "<td>" + data["bonuses"]['attack_crush'] + "</td>" + "<td>" + data["bonuses"]['attack_magic'] + "</td>" + "<td>" + data["bonuses"]['attack_ranged'] + "</td>" + "</tr>";

    var defence_table = "<tr><th colspan='5'>Defence Bonus</th></tr><tr><td><img src='http://osrsbox.com/osrsbox-tooltips/images/stab.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/slash.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/crush.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/magic.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/ranged.png' alt=''></td></tr><tr><td>" + data["bonuses"]['defence_stab'] + "</td>" + "<td>" + data["bonuses"]['defence_slash'] + "</td>" + "<td>" + data["bonuses"]['defence_crush'] + "</td>" + "<td>" + data["bonuses"]['defence_magic'] + "</td>" + "<td>" + data["bonuses"]['defence_ranged'] + "</td>" + "</tr>";

    var other_bonuses_table = "<tr><th colspan='4'>Other Bonuses</th></tr><tr><td><img src='http://osrsbox.com/osrsbox-tooltips/images/melee_strength.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/ranged_strength.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/magic_damage.png' alt=''></td><td><img src='http://osrsbox.com/osrsbox-tooltips/images/prayer.png' alt=''></td></tr><tr><td>" + data["bonuses"]['melee_strength'] + "</td>" + "<td>" + data["bonuses"]['ranged_strength'] + "</td>" + "<td>" + data["bonuses"]['magic_damage'] + "</td>" + "<td>" + data["bonuses"]['prayer'] + "</td>" + "</tr></table>";  

    theContent = "<div>" + header + clear + properties + clear + attack_table + defence_table + other_bonuses_table + "</div>";
    $("#" + data["id"]).tooltip('option', 'content', theContent)
}

    function errorFunction(data) {
        $("#" + data["id"]).tooltip('option', 'content', "Error getting content.")
    }      

function boolToString(boolVal) {
    if (boolVal == true) {
        return "True"
    }
    else {
        return "False"
    }
}