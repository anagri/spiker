module LinkHelper
  def back_to_dashboard
    link_to t('view.common.to_dashboard'), dashboard_path
  end
end