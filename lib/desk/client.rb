module Desk
  # Wrapper for the Desk.com REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {http://dev.desk.com/doc the Desk.com API Documentation}.
  # @see http://dev.desk.com/pages/every_developer
  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'desk/client/article'
    require 'desk/client/brand'
    require 'desk/client/case'
    require 'desk/client/company'
    require 'desk/client/custom_field'
    require 'desk/client/customer'
    require 'desk/client/facebook_user'
    require 'desk/client/filter'
    require 'desk/client/group'
    require 'desk/client/insight'
    require 'desk/client/integration_url'
    require 'desk/client/job'
    require 'desk/client/label'
    require 'desk/client/macro'
    require 'desk/client/mailbox'
    require 'desk/client/rule'
    require 'desk/client/site_setting'
    require 'desk/client/system_message'
    require 'desk/client/topic'
    require 'desk/client/twitter_account'
    require 'desk/client/twitter_user'
    require 'desk/client/user'

    alias :api_endpoint :endpoint

    include Desk::Client::Article
    include Desk::Client::Brand
    include Desk::Client::Case
    include Desk::Client::Company
    include Desk::Client::CustomField
    include Desk::Client::Customer
    include Desk::Client::FacebookUser
    include Desk::Client::Filter
    include Desk::Client::Group
    include Desk::Client::Insight
    include Desk::Client::IntegrationUrl
    include Desk::Client::Job
    include Desk::Client::Label
    include Desk::Client::Macro
    include Desk::Client::Mailbox
    include Desk::Client::Rule
    include Desk::Client::SiteSetting
    include Desk::Client::SystemMessage
    include Desk::Client::Topic
    include Desk::Client::TwitterAccount
    include Desk::Client::TwitterUser
    include Desk::Client::User


    def initialize(options={})
      if !self.respond_to? :endpoints_setup
        self.class.included_modules.each do |m|
          if r = m.name.match(/Desk::Client::([a-zA-z]+)/)
            base = r[1].gsub(/(.)([A-Z])/, '\1_\2').downcase
            if self.respond_to? "#{base}_endpoints"
              endpoints_list = send("#{base}_endpoints")
              setup_functions(base, endpoints_list)
            end
          end
        end
        self.class.send(:define_method, :endpoints_setup) {}
      end
      super(options)
    end

    def plural(singular)
      if singular[-1, 1] == "y"
        singular[0..-2]+"ies"
      elsif singular[-1, 1] == "x"
        singular+"es"
      else
        singular+"s"
      end
    end

    private

    def setup_functions(base, endpoints_list)
      endpoints_list.each do |endpoint|
        eps = endpoint.to_s.split("_")
        endpoint = eps[0]
        bases = plural(base)
        sub_ep = eps[1]
        sub_eps = plural(sub_ep) if sub_ep

        case endpoint
        when "list"
          if sub_ep
            method_name = "list_#{base}_#{sub_ep}"
            alias_names = ["#{base}_#{sub_ep}"]
            block = lambda{ |id, *args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              get("#{bases}/#{id}/#{sub_ep}", options)
            }
          else
            method_name = "list_#{bases}"
            alias_names = [bases]
            block = lambda{ |*args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              searchOptions = options.keys - [:page, :per_page]
              if (!self.respond_to? "search_#{bases}") || searchOptions.empty?
                get(bases, options)
              else
                send("search_#{bases}", options)
              end
            }
          end
        when "search"
          method_name = "search_#{bases}"
          alias_names = []
          block = lambda{ |*args|
            options = args.last.is_a?(Hash) ? args.pop : {}
            get("#{bases}/search", options)
          }
        when "show"
          if sub_ep
            method_name = "show_#{base}_#{sub_ep}"
            alias_names = ["#{base}_#{sub_ep}"]
            block = lambda{ |id, sub_id|
              get("#{bases}/#{id}/#{sub_eps}/#{sub_id}")
            }
          else
            method_name = "show_#{base}"
            alias_names = [base]
            block = lambda{ |id| get("#{bases}/#{id}") }
          end
        when "create"
          if sub_ep
            method_name = "create_#{base}_#{sub_ep}"
            alias_names = []
            block = lambda{ |id, *args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              post("#{bases}/#{id}/#{sub_eps}", options)
            }
          else
            method_name = "create_#{base}"
            alias_names = []
            block = lambda{ |*args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              post("#{bases}", options)
            }
          end
        when "update"
          if sub_ep
            method_name = "update_#{base}_#{sub_ep}"
            alias_names = []
            block = lambda{ |id, sub_id, *args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              patch("#{bases}/#{id}/#{sub_eps}/#{sub_id}", options)
            }
          else
            method_name = "update_#{base}"
            alias_names = []
            block = lambda{ |id, *args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              patch("#{bases}/#{id}", options)
            }
          end
        when "delete"
          if sub_ep
            method_name = "delete_#{base}_#{sub_ep}"
            alias_names = []
            block = lambda{ |id, sub_id|
              delete("#{bases}/#{id}/#{sub_eps}/#{sub_id}")
            }
          else
            method_name = "delete_#{base}"
            alias_names = []
            block = lambda{ |id| delete("#{bases}/#{id}") }
          end
        end
        self.class.send(:define_method, method_name, block)
        alias_names.each do |alias_name|
          self.class.send(:alias_method, alias_name, method_name)
        end
      end
    end

  end
end
