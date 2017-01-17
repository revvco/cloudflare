require "cloudflare/version"

module Cloudflare
  autoload :VERSION, 'cloudflare/version'

  module Host
    autoload :Api, 'cloudflare/host/api'
    
    module Services
      autoload :BaseService, 'cloudflare/host/services/base_service'
      autoload :ZoneService, 'cloudflare/host/services/zone_service'
    end
  end

  module Client
    autoload :Api, 'cloudflare/client/api'
    
    module Services
      autoload :BaseService, 'cloudflare/client/services/base_service'
      autoload :ZoneService, 'cloudflare/client/services/zone_service'
    end
  end

  module Exceptions
    autoload :ServiceException, 'cloudflare/exceptions/service_exception'
  end

  module Util
    autoload :Config, 'cloudflare/util/config'
    autoload :Helpers, 'cloudflare/util/helpers'
    autoload :Component, 'cloudflare/util/component'
  end
end
