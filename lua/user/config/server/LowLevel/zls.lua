local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('zls', {
    cmd = { 'zls' },
    filetypes = { 'zig', 'zir' },
    root_markers = { 'zls.json', 'build.zig', '.git' },
    capabilities = capabilities,
    flags = {
        debounce_text_changes = 300,  -- Same as your Rust setup
    },
})

vim.lsp.enable('zls')

-- Disable annoying shutdown errors
vim.lsp.handlers["$/progress"] = function() end

-- mkdir zig && cd zig && zig init && zig build 

-- create zls.json and add in project root 
-- {
--     "$schema": "https://raw.githubusercontent.com/zigtools/zls/master/schemas/config.schema.json",
--     
--     "enable_snippets": false,
--     "enable_ast_check_diagnostics": true,
--     "enable_autofix": true,
--     "enable_import_embedfile_argument_completions": true,
--     
--     "enable_build_on_save": false,
--     "build_on_save_step": "check",
--     
--     "enable_inlay_hints": false,
--     "inlay_hints_show_variable_type_hints": false,
--     "inlay_hints_show_parameter_name": false,
--     "inlay_hints_show_builtin": false,
--     "inlay_hints_exclude_single_argument": true,
--     "inlay_hints_hide_redundant_param_names": true,
--     "inlay_hints_hide_redundant_param_names_last_token": true,
--     
--     "warn_style": false,
--     "highlight_global_var_declarations": true,
--     
--     "dangerous_comptime_experiments_do_not_enable": false,
--     
--     "skip_std_references": false,
--     "prefer_ast_check_as_child_process": true,
--     
--     "completions_with_replace": false,
--     "completion_label_details": true,
--     
--     "semantic_tokens": "partial",
--     "enable_semantic_tokens": true,
--     
--     "operator_completions": true,
--     "include_at_in_builtins": false,
--     
--     "max_detail_length": 1048576,
--     
--     "record_session": false,
--     "builtin_completion_documentation": true
-- }
--

-- add this into build.zig as of version 0.15.2
-- const std = @import("std");
--
-- pub fn build(b: *std.Build) void {
--     const target = b.standardTargetOptions(.{});
--     const optimize = b.standardOptimizeOption(.{});
--
--     const exe = b.addExecutable(.{
--         .name = "pro",
--         .root_module = b.createModule(.{
--             .root_source_file = b.path("src/main.zig"),
--             .target = target,
--             .optimize = optimize,
--         }),
--     });
--
--     b.installArtifact(exe);
--
--     const run_cmd = b.addRunArtifact(exe);
--     run_cmd.step.dependOn(b.getInstallStep());
--     if (b.args) |args| {
--         run_cmd.addArgs(args);
--     }
--
--     const run_step = b.step("run", "Run the app");
--     run_step.dependOn(&run_cmd.step);
--
--     // Add check step for ZLS
--     const exe_check = b.addExecutable(.{
--         .name = "pro",
--         .root_module = b.createModule(.{
--             .root_source_file = b.path("src/main.zig"),
--             .target = target,
--             .optimize = optimize,
--         }),
--     });
--
--     const check_step = b.step("check", "Check if the project compiles");
--     check_step.dependOn(&exe_check.step);
-- }
