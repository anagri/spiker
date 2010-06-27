module LinkHelper
  def back_to_dashboard
    link_to t('view.index.to_dashboard'), dashboard_path
  end
end