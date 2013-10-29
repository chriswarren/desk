module Desk
  # Wrapper for the Desk.com REST API
  #
  # @note All methods have been separated into modules and follow the same grouping used in {http://dev.desk.com/doc the Desk.com API Documentation}.
  # @see http://dev.desk.com/pages/every_developer
  class Client < API
    # Require client method modules after initializing the Client class in
    # order to avoid a superclass mismatch error, allowing those modules to be
    # Client-namespaced.
    require 'desk/client/attachment'
    require 'desk/client/user'
    require 'desk/client/group'
    require 'desk/client/case'
    require 'desk/client/customer'
    require 'desk/client/topic'
    require 'desk/client/article'
    require 'desk/client/macro'

    alias :api_endpoint :endpoint

    include Desk::Client::Attachment
    include Desk::Client::User
    include Desk::Client::Group
    include Desk::Client::Case
    include Desk::Client::Customer
    include Desk::Client::Topic
    include Desk::Client::Article
    include Desk::Client::Macro


    def initialize(options={})
      if !self.respond_to? :fns_setup
        self.class.included_modules.each do |m|
          if r = m.name.match(/Desk::Client::([a-zA-z]+)/)
            base = r[1].downcase
            if self.respond_to? "#{base}_fns"
              fns_list = send("#{base}_fns")
              setup_functions(base, fns_list)
            end
          end
        end
        self.class.send(:define_method, :fns_setup) {}
      end
      super(options)
    end

    private

    def setup_functions(base, fns_list)
      fns_list.each do |function|
        fs = function.to_s.split("_")
        fn = fs[0]
        bases = plural(base)
        sub_fn = fs[1]
        sub_fns = plural(sub_fn) if sub_fn

        case fn
        when "list"
          if sub_fn
            method_name = "list_#{base}_#{sub_fn}"
            alias_names = ["#{base}_#{sub_fn}"]
            block = lambda{ |id, *args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              get("#{bases}/#{id}/#{sub_fn}", options)
            }
          else
            method_name = "list_#{bases}"
            alias_names = []
            block = lambda{ |*args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              get("#{bases}", options)
            }
          end
        when "search"
          method_name = "search_#{bases}"
          alias_names = ["#{bases}"]
          block = lambda{ |*args|
            options = args.last.is_a?(Hash) ? args.pop : {}
            searchOptions = options.keys - [:page, :per_page]
            if searchOptions.empty?
              send("list_#{bases}", options)
            else
              get("#{bases}/search", options)
            end
          }
        when "show"
          if sub_fn
            method_name = "show_#{base}_#{sub_fn}"
            alias_names = ["#{base}_#{sub_fn}"]
            block = lambda{ |id, sub_id|
              get("#{bases}/#{id}/#{sub_fns}/#{sub_id}")
            }
          else
            method_name = "show_#{base}"
            alias_names = [base]
            block = lambda{ |id| get("#{bases}/#{id}") }
          end
        when "create"
          if sub_fn
            method_name = "create_#{base}_#{sub_fn}"
            alias_names = []
            block = lambda{ |id, *args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              post("#{bases}/#{id}/#{sub_fns}", options)
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
          if sub_fn
            method_name = "update_#{base}_#{sub_fn}"
            alias_names = []
            block = lambda{ |id, sub_id, *args|
              options = args.last.is_a?(Hash) ? args.pop : {}
              patch("#{bases}/#{id}/#{sub_fns}/#{sub_id}", options)
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
          if sub_fn
            method_name = "delete_#{base}_#{sub_fn}"
            alias_names = []
            block = lambda{ |id, sub_id|
              delete("#{bases}/#{id}/#{sub_fns}/#{sub_id}")
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

    def plural(singular)
      if singular[-1, 1] == "y"
        singular[0..-2]+"ies"
      else
        singular+"s"
      end
    end

  end
end
