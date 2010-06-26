require 'metric_fu'

MetricFu::Configuration.run do |config|
  #define which metrics you want to use
  config.metrics = [:churn, :saikuro, :stats, :flog, :flay, :reek, :roodi, :rcov]
  config.flay = { :dirs_to_flay => ['app', 'spec', 'lib'] }
  config.flog = { :dirs_to_flog => ['app', 'spec', 'lib'] }
  config.reek = { :dirs_to_reek => ['app', 'spec', 'lib'] }
  config.roodi = { :dirs_to_roodi => ['app', 'spec', 'lib'] }
  config.saikuro = { :output_directory => 'scratch_directory/saikuro',
                     :input_directory => ['app', 'spec', 'lib'],
                     :cyclo => "",
                     :filter_cyclo => "0",
                     :warn_cyclo => "5",
                     :error_cyclo => "7",
                     :formater => "text"}
  config.churn = { :start_date => "1 year ago", :minimum_churn_count => 10}
  config.rcov[:rcov_opts] << "-Itest"
end
