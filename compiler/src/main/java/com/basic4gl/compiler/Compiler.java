package com.basic4gl.compiler;

import java.io.OutputStream;
import com.basic4gl.compiler.ast.*;
import com.basic4gl.runtime.CodeBlock;

/**
 * Compiles the given SyntaxNode
 */
public class Compiler {
	private OutputStream out;

	public Compiler(OutputStream out) {
		this.out = out;
	}

	public CodeBlock compile(SyntaxNode sn) {
		CodeBlock block = new CodeBlock();
		return block;
	}
}
