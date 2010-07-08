module NavigateHelper
  def navigate_html_options
    [
            [t('view.dashboard.tab'), dashboard_path],
            [t('view.offices.tab'), url_for(:controller => 'dashboard', :action => 'offices')],
            [t('view.clients.tab'), dashboard_path],
            [t('view.users.tab'), users_path],
            [t('view.products.tab'), dashboard_path],
            [t('view.reports.tab'), dashboard_path],
            [t('view.accounts.tab'), dashboard_path],
            [t('view.system.tab'), dashboard_path]
    ]
  end
end