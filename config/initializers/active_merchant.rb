case RAILS_ENV
when 'development'
  ActiveMerchant::Billing::Base.mode = :test
end

AUTHORIZE_NET_CREDENTIALS = YAML.load_file("#{RAILS_ROOT}/config/authorize_net.yml")[RAILS_ENV].symbolize_keys