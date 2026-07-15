# frozen_string_literal: true

require 'plugs'

module Antlers
  class Elements
    include Plugs

    plug(:root) do
      plug(:node) do
        require_relative '../nodes/root_node'
        RootNode
      end
    end

    plug(:html) do
      plug(:node) do
        require_relative '../nodes/html_node'
        HTMLNode
      end
    end

    plug(:form) do
      plug(:lexeme) do
        require_relative '../lexemes/form_lexeme'
        FormLexeme
      end

      plug(:node) do
        require_relative '../nodes/form_node'
        FormNode
      end
    end

    plug(:for) do
      plug(:lexeme) do
        require_relative '../lexemes/for_lexeme'
        ForLexeme
      end

      plug(:node) do
        require_relative '../nodes/for_node'
        ForNode
      end
    end

    plug(:if) do
      plug(:lexeme) do
        require_relative '../lexemes/if_lexeme'
        IfLexeme
      end

      plug(:node) do
        require_relative '../nodes/if_node'
        IfNode
      end
    end

    plug(:prop) do
      plug(:lexeme) do
        require_relative '../lexemes/prop_lexeme'
        PropLexeme
      end

      plug(:node) do
        require_relative '../nodes/prop_node'
        PropNode
      end
    end

    plug(:slot) do
      plug(:lexeme) do
        require_relative '../lexemes/slot_lexeme'
        SlotLexeme
      end

      plug(:node) do
        require_relative '../nodes/slot_node'
        SlotNode
      end
    end

    plug(:yield) do
      plug(:lexeme) do
        require_relative '../lexemes/yield_lexeme'
        YieldLexeme
      end

      plug(:node) do
        require_relative '../nodes/yield_node'
        YieldNode
      end
    end

    plug(:var) do
      plug(:node) do
        require_relative '../nodes/var_node'
        VarNode
      end
    end
  end
end
