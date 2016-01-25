$(document).on('click', '#add-skill-link', onAddSkillLinkClick);
$(document).on('click', '.remove-skill-link', onRemoveSkillLinkClick);

function onAddSkillLinkClick(event){
  event.preventDefault();
  addSkill();
  $("#new_skill").val("");
  return false;
}

function onRemoveSkillLinkClick(event){
  event.preventDefault();
  var skill = $(this).prev().text();
  removeSkill(skill);
  $(this).parent().remove();
  return false;
}

function addSkill(){
  var skill = $("#new_skill").val();
  if(skill){
    var skill_list = $("#skill_list").val();
    $("#skill_list").val(skill_list + ", " + skill);
    createSkillTag(skill);
  }
}

function removeSkill(skill){
  var skill_list = $("#skill_list").val();
  $("#skill_list").val(skill_list.replace(skill,""));
}

function createSkillTag(skill){
  var new_skill = $("<div class='skill btn btn-primary btn-sm'></div>")
  var skill_text = $("<span></span>").text(skill);
  var remove_skill_link = $("<a class='remove-skill-link' href='#' aria-hidden='true'><span class='glyphicon glyphicon-remove'></span></a>");
  new_skill.append(skill_text);
  new_skill.append(remove_skill_link);
  $(".skills").append(new_skill);
}
