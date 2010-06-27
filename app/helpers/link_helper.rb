module LinkHelper
  def back_link
    if params[:controller] == 'dashboard'
      return ''
    elsif (params[:action] == 'show' || params[:action] == 'new' || params[:action] == 'edit') && respond_to?(:"#{params[:controller]}_path")
      return link_to 'Back', send("#{params[:controller]}_path")
    else
      return link_to 'Back', dashboard_path
    end
  end
end