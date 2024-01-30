"""Checks if an NPM package needs to be published."""

def _create_shell(ctx):
    out_file = ctx.actions.declare_file(ctx.label.name + ".bash")

    ctx.actions.run(
        outputs = [out_file],
        arguments = ["nonsense", out_file.path],
        executable = ctx.executable._process_wrapper,
    )
    return [DefaultInfo(
        files = depset([out_file]),
    )]


create_shell = rule(
    implementation = _create_shell,
    attrs = {
        "_process_wrapper": attr.label(
            doc = "A process wrapper for running rustc on all platforms.",
            default = Label("//:wrapper"),
            executable = True,
            allow_single_file = True,
            cfg = "exec",
        ),
    },
)
