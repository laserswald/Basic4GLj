package com.basic4gl.compiler.ast;

/**
 * SyntaxNode
 */
public abstract class SyntaxNode {
	protected SyntaxNode() {
	}

	abstract <R> R accept(Visitor<R> visitor);
}
