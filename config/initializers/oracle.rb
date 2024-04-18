exit if ENV['SKIP_INIT'] == 'yes'

if ActiveRecord::Base.connection.adapter_name == "OracleEnhanced"

  ActiveSupport.on_load(:active_record) do
    ActiveRecord::ConnectionAdapters::OracleEnhancedAdapter.class_eval do
      #self.emulate_integers_by_column_name = true
      #self.emulate_dates_by_column_name = true
      #self.string_to_date_format = "%d.%m.%Y"
      #self.string_to_time_format = "%d.%m.%Y %H:%M:%S"
      def self.is_integer_column? (name, table_name = nil)
        name =~ /((^|_)id$|_cnt$)/i
      end
    end
  end
  
  require "ruby-plsql"
  plsql.activerecord_class = ActiveRecord::Base
   
end 

module ActiveRecord::ConnectionAdapters
  class TableDefinition
    def number (*args)
      options = args.extract_options!
      column_names = args
      if ActiveRecord::Base.connection.adapter_name == "OracleEnhanced"
        column_names.each { |name| column(name, 'number', options) }
      else
        column_names.each { |name| column(name, 'decimal', options) }
      end        
    end
    def decimal (*args)
      options = args.extract_options!
      column_names = args
      if ActiveRecord::Base.connection.adapter_name == "OracleEnhanced"
        column_names.each { |name| column(name, 'number', options) }
      else
        column_names.each { |name| column(name, 'decimal', options) }
      end        
    end    
  end
  class Table
    def number (*args)
      options = args.extract_options!
      column_names = args
      if ActiveRecord::Base.connection.adapter_name == "OracleEnhanced"
        column_names.each { |name| column(name, 'number', options) }
      else
        column_names.each { |name| column(name, 'decimal', options) }
      end        
    end
    def decimal (*args)
      options = args.extract_options!
      column_names = args
      if ActiveRecord::Base.connection.adapter_name == "OracleEnhanced"
        column_names.each { |name| column(name, 'number', options) }
      else
        column_names.each { |name| column(name, 'decimal', options) }
      end        
    end    
  end
end
