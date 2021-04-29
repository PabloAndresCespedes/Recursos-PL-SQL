create or replace procedure render_mask_field (
                     p_item    in apex_plugin.t_item,
                     p_plugin  in apex_plugin.t_plugin,
                     p_param   in apex_plugin.t_item_render_param,
                     p_result  in out nocopy apex_plugin.t_item_render_result
                     )
is
  /* here we define a plugin attribute used by the developer to set the item mask */
  lv_format_mask varchar2(100) := p_item.attribute_01;
  lv_type_input  varchar2(100) := nvl(p_item.attribute_02, 'text');

  /* we need to call the following function to allow apex to map the submitted value to the actual page item in session state.
  this function returns the mapping name for your page item. if the html input element has multiple values then set p_is_multi_value to true.*/
  lv_item_name varchar2(1000) := apex_plugin.get_input_name_for_page_item(false);
begin
  /* this outputs the necessary html code to render a text field*/
  sys.htp.p('<input maxlength="'||nvl(p_item.element_max_length, '90')||'"
                    id="'||p_item.name||'"
                    class="text_field apex-item-text '||p_item.element_css_classes||'"
                    name="'||lv_item_name||'"
                    size="'||p_item.element_width||'"
                    type="'||lv_type_input||'"
                    value="'||sys.htf.escape_sc(p_param.value)||'"
                    placeholder="'||p_item.placeholder||'" />'
        );
  /* here we call the javascript to set the mask to the item $('#p1_total').mask('000.000.000.000.000,00'); */
  apex_javascript.add_onload_code('$("#'||p_item.name||'").mask("'||lv_format_mask||'")');

end render_mask_field;
/
