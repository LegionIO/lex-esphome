# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module AlarmControlPanel
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def alarm_state(device:, entity:, **)
            connection(device: device).get("/alarm_control_panel/#{entity}").body
          end

          def alarm_arm_away(device:, entity:, code: nil, **)
            alarm_post(device, entity, 'arm_away', code)
          end

          def alarm_arm_home(device:, entity:, code: nil, **)
            alarm_post(device, entity, 'arm_home', code)
          end

          def alarm_arm_night(device:, entity:, code: nil, **)
            alarm_post(device, entity, 'arm_night', code)
          end

          def alarm_arm_vacation(device:, entity:, code: nil, **)
            alarm_post(device, entity, 'arm_vacation', code)
          end

          def alarm_disarm(device:, entity:, code: nil, **)
            alarm_post(device, entity, 'disarm', code)
          end

          private

          def alarm_post(device, entity, action, code)
            connection(device: device).post("/alarm_control_panel/#{entity}/#{action}") do |req|
              req.body = "code=#{code}" if code
            end.body
          end
        end
      end
    end
  end
end
