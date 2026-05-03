# frozen_string_literal: true

module Legion
  module Extensions
    module Esphome
      module Runners
        module MediaPlayer
          include Legion::Extensions::Helpers::Lex if defined?(Legion::Extensions::Helpers::Lex)
          extend Legion::Extensions::Esphome::Helpers::Client if defined?(Legion::Extensions::Esphome::Helpers::Client)

          def media_player_state(device:, entity:, **)
            connection(device: device).get("/media_player/#{entity}").body
          end

          def media_player_play(device:, entity:, **)
            connection(device: device).post("/media_player/#{entity}/play").body
          end

          def media_player_pause(device:, entity:, **)
            connection(device: device).post("/media_player/#{entity}/pause").body
          end

          def media_player_stop(device:, entity:, **)
            connection(device: device).post("/media_player/#{entity}/stop").body
          end

          def media_player_set_volume(device:, entity:, volume:, **)
            connection(device: device).post("/media_player/#{entity}/set") do |req|
              req.params = { volume: volume }
            end.body
          end
        end
      end
    end
  end
end
