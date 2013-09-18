module Desk
  class Client
    module Note

      def list_notes(case_id, note_id = nil)
        specific_note = note_id ? "/#{note_id}" : ""
        get("cases/#{case_id}/notes#{specific_note}")
      end
      alias_method :notes, :list_notes
      alias_method :show_note, :list_notes

      def create_note(case_id, *args)
        options = args.last.is_a?(Hash) ? args.pop : {}
        post("cases/#{case_id}/notes", options)
      end
      alias_method :note, :create_note

    end
  end
end
