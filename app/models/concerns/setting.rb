require 'active_support/concern'

module Setting
  extend ActiveSupport::Concern
  included do
    SETTING_TYPES = ['text','number','date']

    store :setting1, accessors: [:setting1_name, :setting1_type, :setting1_value], coder: JSON
    store :setting2, accessors: [:setting2_name, :setting2_type, :setting2_value], coder: JSON
    store :setting3, accessors: [:setting3_name, :setting3_type, :setting3_value], coder: JSON
    store :setting4, accessors: [:setting4_name, :setting4_type, :setting4_value], coder: JSON
    store :setting5, accessors: [:setting5_name, :setting5_type, :setting5_value], coder: JSON

    validate :settings_should_be_correct

    validates_presence_of :setting1_name, if: -> {"setting1_name.blank? && !setting2_name.blank?"}, message: "can't be blank when Setting2 name is present"
    validates_presence_of :setting2_name, if: -> {"setting2_name.blank? && !setting3_name.blank?"}, message: "can't be blank when Setting3 name is present"
    validates_presence_of :setting3_name, if: -> {"setting3_name.blank? && !setting4_name.blank?"}, message: "can't be blank when Setting4 name is present"
    validates_presence_of :setting4_name, if: -> {"setting4_name.blank? && !setting5_name.blank?"}, message: "can't be blank when Setting5 name is present"

    before_save :set_settings_cnt
    before_save :encrypt_password_settings
    after_save :decrypt_password_settings
    after_find :decrypt_password_settings

    if self::TOTAL_SETTINGS_COUNT == 10
      store :setting6, accessors: [:setting6_name, :setting6_type, :setting6_value], coder: JSON
      store :setting7, accessors: [:setting7_name, :setting7_type, :setting7_value], coder: JSON
      store :setting8, accessors: [:setting8_name, :setting8_type, :setting8_value], coder: JSON
      store :setting9, accessors: [:setting9_name, :setting9_type, :setting9_value], coder: JSON
      store :setting10, accessors: [:setting10_name, :setting10_type, :setting10_value], coder: JSON

      validates_presence_of :setting5_name, if: -> {"setting5_name.blank? && !setting6_name.blank?"}, message: "can't be blank when Setting6 name is present"
      validates_presence_of :setting6_name, if: -> {"setting6_name.blank? && !setting7_name.blank?"}, message: "can't be blank when Setting7 name is present"
      validates_presence_of :setting7_name, if: -> {"setting7_name.blank? && !setting8_name.blank?"}, message: "can't be blank when Setting8 name is present"
      validates_presence_of :setting8_name, if: -> {"setting8_name.blank? && !setting9_name.blank?"}, message: "can't be blank when Setting9 name is present"
      validates_presence_of :setting9_name, if: -> {"setting9_name.blank? && !setting10_name.blank?"}, message: "can't be blank when Setting10 name is present"
    end

    def set_settings_cnt
      self.settings_cnt = 0
      self.settings_cnt += 1 unless setting1_name.blank?
      self.settings_cnt += 1 unless setting2_name.blank?
      self.settings_cnt += 1 unless setting3_name.blank?
      self.settings_cnt += 1 unless setting4_name.blank?
      self.settings_cnt += 1 unless setting5_name.blank?

      if self.class::TOTAL_SETTINGS_COUNT == 10
        self.settings_cnt += 1 unless setting6_name.blank?
        self.settings_cnt += 1 unless setting7_name.blank?
        self.settings_cnt += 1 unless setting8_name.blank?
        self.settings_cnt += 1 unless setting9_name.blank?
        self.settings_cnt += 1 unless setting10_name.blank?
      end
    end    

    def settings_should_be_correct
      validate_setting(:setting1_value, setting1_name, setting1_type, setting1_value)
      validate_setting(:setting2_value, setting2_name, setting2_type, setting2_value)
      validate_setting(:setting3_value, setting3_name, setting3_type, setting3_value)
      validate_setting(:setting4_value, setting4_name, setting4_type, setting4_value)
      validate_setting(:setting5_value, setting5_name, setting5_type, setting5_value)

      if self.class::TOTAL_SETTINGS_COUNT == 10
        validate_setting(:setting6_value, setting6_name, setting6_type, setting6_value)
        validate_setting(:setting7_value, setting7_name, setting7_type, setting7_value)
        validate_setting(:setting8_value, setting8_name, setting8_type, setting8_value)
        validate_setting(:setting9_value, setting9_name, setting9_type, setting9_value)
        validate_setting(:setting10_value, setting10_name, setting10_type, setting10_value)
      end
    end

    def validate_setting(attr_name, setting_name, setting_type, setting_value)
      errors.add(setting_name, "can't be blank") if setting_name.present? && setting_value.blank?
      if setting_name.present? and setting_value.present?
        errors.add(setting_name, "invalid format, the correct format is yyyy-mm-dd") if (setting_type == "date" && setting_value =~ /\A\d{4}\-\d{2}\-\d{2}+$\z/).nil?
        Time.zone.parse setting_value rescue errors.add(setting_name, "is not a date") if setting_type == "date"
        errors.add(setting_name, "is longer than maximum (100)") if setting_type == "text" && setting_value.length > 100
        errors.add(setting_name, "should include only digits") if setting_type == "number" && (setting_value =~ /\A[0-9]+$\z/).nil?
      end
    end

    def decrypt_password_settings
      unless settings_cnt == 0
        i = 1
        while i <= settings_cnt
          self.send("setting#{i}_value=", DecPassGenerator.new(send("setting#{i}_value"),ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_decrypted_data) if send("setting#{i}_type") == 'password'
          i = i + 1
        end
      end
    end

    def encrypt_password_settings
      unless settings_cnt == 0
        i = 1
        while i <= settings_cnt
          self.send("setting#{i}_value=", EncPassGenerator.new(send("setting#{i}_value"),ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET']).generate_encrypted_password) if send("setting#{i}_type") == 'password'
          i = i + 1
        end
      end
    end
  end
end
