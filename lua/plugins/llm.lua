return {
    'ggml-org/llama.vim',
    init = function ()
        vim.g.llama_config = {
            auto_fim = false,
            endpoint_inst = "192.168.56.1:8080/v1/chat/completions"
        }
    end
}

