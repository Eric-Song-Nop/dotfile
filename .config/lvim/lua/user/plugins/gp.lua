return {
	"robitx/gp.nvim",
	config = function()
		require("gp").setup({
			openai_api_key = { "bw", "get", "notes", "openai_key" },
			chat_user_prefix = "🗨:",
			chat_assistant_prefix = { "🤖:", "[{{agent}}]" },
			chat_topic_gen_prompt = "Summarize the topic of our conversation above"
				.. " in two or three words. Respond only with those words.",
			chat_topic_gen_model = "gpt-3.5-turbo-16k",
			agents = {
				{
					name = "ChatGPT4",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are a general AI assistant.\n\n"
						.. "The user provided the additional info about how they would like you to respond:\n\n"
						.. "- If you're unsure don't guess and say you don't know instead.\n"
						.. "- Ask question if you need clarification to provide better answer.\n"
						.. "- Think deeply and carefully from first principles step by step.\n"
						.. "- Zoom out first to see the big picture and then zoom in to details.\n"
						.. "- Use Socratic method to improve your thinking and coding skills.\n"
						.. "- Don't elide any code from your output if the answer requires coding.\n"
						.. "- Take a deep breath; You've got this!\n",
				},
				{
					name = "ChatGPT3-5",
					chat = true,
					command = false,
					-- string with model name or table with model name and parameters
					model = { model = "gpt-3.5-turbo-1106", temperature = 1.1, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are a general AI assistant.\n\n"
						.. "The user provided the additional info about how they would like you to respond:\n\n"
						.. "- If you're unsure don't guess and say you don't know instead.\n"
						.. "- Ask question if you need clarification to provide better answer.\n"
						.. "- Think deeply and carefully from first principles step by step.\n"
						.. "- Zoom out first to see the big picture and then zoom in to details.\n"
						.. "- Use Socratic method to improve your thinking and coding skills.\n"
						.. "- Don't elide any code from your output if the answer requires coding.\n"
						.. "- Take a deep breath; You've got this!\n",
				},
				{
					name = "CodeGPT4",
					chat = false,
					command = true,
					-- string with model name or table with model name and parameters
					model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are an AI working as a code editor.\n\n"
						.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
						.. "START AND END YOUR ANSWER WITH:\n\n```",
				},
				{
					name = "CodeGPT3-5",
					chat = false,
					command = true,
					-- string with model name or table with model name and parameters
					model = { model = "gpt-3.5-turbo-1106", temperature = 0.8, top_p = 1 },
					-- system prompt (use this to specify the persona/role of the AI)
					system_prompt = "You are an AI working as a code editor.\n\n"
						.. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
						.. "START AND END YOUR ANSWER WITH:\n\n```",
				},
			},
			hooks = {
				InspectPlugin = function(plugin, params)
					local bufnr = vim.api.nvim_create_buf(false, true)
					local copy = vim.deepcopy(plugin)
					local key = copy.config.openai_api_key
					copy.config.openai_api_key = key:sub(1, 3) .. string.rep("*", #key - 6) .. key:sub(-3)
					local plugin_info = string.format("Plugin structure:\n%s", vim.inspect(copy))
					local params_info = string.format("Command params:\n%s", vim.inspect(params))
					local lines = vim.split(plugin_info .. "\n" .. params_info, "\n")
					vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
					vim.api.nvim_win_set_buf(0, bufnr)
				end,

				-- GpImplement rewrites the provided selection/range based on comments in it
				Implement = function(gp, params)
					local template = "Having following from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please rewrite this according to the contained instructions."
						.. "\n\nRespond exclusively with the snippet that should replace the selection above."

					local agent = gp.get_command_agent()
					gp.info("Implementing selection with agent: " .. agent.name)

					gp.Prompt(
						params,
						gp.Target.rewrite,
						nil, -- command will run directly without any prompting for user input
						agent.model,
						template,
						agent.system_prompt
					)
				end,

				-- your own functions can go here, see README for more examples like
				-- :GpExplain, :GpUnitTests.., :GpTranslator etc.

				-- -- example of making :%GpChatNew a dedicated command which
				-- -- opens new chat with the entire current buffer as a context
				-- BufferChatNew = function(gp, _)
				-- 	-- call GpChatNew command in range mode on whole buffer
				-- 	vim.api.nvim_command("%" .. gp.config.cmd_prefix .. "ChatNew")
				-- end,

				-- -- example of adding command which opens new chat dedicated for translation
				-- Translator = function(gp, params)
				-- 	local agent = gp.get_command_agent()
				-- 	local chat_system_prompt = "You are a Translator, please translate between English and Chinese."
				-- 	gp.cmd.ChatNew(params, agent.model, chat_system_prompt)
				-- end,

				-- -- example of adding command which writes unit tests for the selected code
				UnitTests = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please respond by writing table driven unit tests for the code above."
					local agent = gp.get_command_agent()
					gp.Prompt(params, gp.Target.enew, nil, agent.model, template, agent.system_prompt)
				end,

				-- -- example of adding command which explains the selected code
				Explain = function(gp, params)
					local template = "I have the following code from {{filename}}:\n\n"
						.. "```{{filetype}}\n{{selection}}\n```\n\n"
						.. "Please respond by explaining the code above."
					local agent = gp.get_chat_agent()
					gp.Prompt(params, gp.Target.popup, nil, agent.model, template, agent.system_prompt)
				end,
			},
		})
		lvim.builtin.which_key.mappings["c"] = {
			name = "ChatGPT",
			c = { "<cmd>GpChatNew<cr>", "New Chat" },
			t = { "<cmd>GpChatToggle<cr>", "Toggle Chat" },
			f = { "<cmd>GpChatFinder<cr>", "Chat Finder" },

			["<C-x>"] = { "<cmd>GpChatNew split<cr>", "New Chat split" },
			["<C-v>"] = { "<cmd>GpChatNew vsplit<cr>", "New Chat vsplit" },
			["<C-t>"] = { "<cmd>GpChatNew tabnew<cr>", "New Chat tabnew" },

			r = { "<cmd>GpRewrite<cr>", "Inline Rewrite" },
			a = { "<cmd>GpAppend<cr>", "Append (after)" },
			b = { "<cmd>GpPrepend<cr>", "Prepend (before)" },

			g = {
				name = "generate into new ..",
				p = { "<cmd>GpPopup<cr>", "Popup" },
				e = { "<cmd>GpEnew<cr>", "GpEnew" },
				n = { "<cmd>GpNew<cr>", "GpNew" },
				v = { "<cmd>GpVnew<cr>", "GpVnew" },
				t = { "<cmd>GpTabnew<cr>", "GpTabnew" },
			},

			n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
			s = { "<cmd>GpStop<cr>", "GpStop" },
			x = { "<cmd>GpContext<cr>", "Toggle GpContext" },
		}
		require("which-key").register({
			c = {
                name = "ChatGpt Visual",
				c = { ":<C-u>'<,'>GpChatNew<cr>", "Visual Chat New" },
				p = { ":<C-u>'<,'>GpChatPaste<cr>", "Visual Chat Paste" },
				t = { ":<C-u>'<,'>GpChatToggle<cr>", "Visual Toggle Chat" },

				["<C-x>"] = { ":<C-u>'<,'>GpChatNew split<cr>", "Visual Chat New split" },
				["<C-v>"] = { ":<C-u>'<,'>GpChatNew vsplit<cr>", "Visual Chat New vsplit" },
				["<C-t>"] = { ":<C-u>'<,'>GpChatNew tabnew<cr>", "Visual Chat New tabnew" },

				r = { ":<C-u>'<,'>GpRewrite<cr>", "Visual Rewrite" },
				a = { ":<C-u>'<,'>GpAppend<cr>", "Visual Append (after)" },
				b = { ":<C-u>'<,'>GpPrepend<cr>", "Visual Prepend (before)" },
				i = { ":<C-u>'<,'>GpImplement<cr>", "Implement selection" },

				g = {
					name = "generate into new ..",
					p = { ":<C-u>'<,'>GpPopup<cr>", "Visual Popup" },
					e = { ":<C-u>'<,'>GpEnew<cr>", "Visual GpEnew" },
					n = { ":<C-u>'<,'>GpNew<cr>", "Visual GpNew" },
					v = { ":<C-u>'<,'>GpVnew<cr>", "Visual GpVnew" },
					t = { ":<C-u>'<,'>GpTabnew<cr>", "Visual GpTabnew" },
				},

				n = { "<cmd>GpNextAgent<cr>", "Next Agent" },
				s = { "<cmd>GpStop<cr>", "GpStop" },
				x = { ":<C-u>'<,'>GpContext<cr>", "Visual GpContext" },
			},
		}, {
			mode = "v", -- VISUAL mode
			prefix = "<leader>",
			buffer = nil,
			silent = true,
			noremap = true,
			nowait = true,
		})
	end,
}
