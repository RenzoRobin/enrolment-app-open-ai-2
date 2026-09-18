def build_implementation_prompt(task_prompt: str, evidence: str) -> str:
    example_request = "Validate that all MCP tools are defined, callable, and bounded correctly."
    filled_prompt = task_prompt.replace("{{USER_REQUEST}}", example_request)
    return f"""
{filled_prompt}

Review Scope:
MCP Tool Integration

Observed Evidence:
{evidence}
...
""".strip()

def build_review_prompt(implementation_output: str, evidence: str) -> str:
    return f"""
Implementation Recommendation:
{implementation_output}

Observed Evidence:
{evidence}

Validate the MCP integration assessment against the evidence.
Identify any gaps or risks in tool definitions or boundaries.

Reply in at most 40 words and stay evidence-based.
""".strip()