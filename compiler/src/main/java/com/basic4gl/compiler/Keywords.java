package com.basic4gl.compiler;

import java.util.HashMap;
import java.util.HashSet;

public final class Keywords {
	private HashSet<String> keywords;

	public Keywords() {
		this.keywords = new HashSet<>();
	}

	public void add(String kw) {
		this.keywords.add(kw);
	}

	public boolean contains(String kw) {
		return this.keywords.contains(kw);
	}

	private class Trie {

		private class Node {
			// A prefix of a set of words in this trie.
			private String prefix;

			// True if the prefix of this node is a valid word.
			private boolean endOfWord;

			// Nodes containing suffixes of this prefix.
			private HashMap<Character, Node> children;

			public Node() {
			}

			public boolean contains(String s) {
				if (prefix.equals(s) && endOfWord) {
					return true;
				}

				if (!s.startsWith(prefix)) {
					return false;
				}

				// cut the matching prefix out of the input string
				String rest = s.substring(prefix.length());

				// get the first letter of the new string
				Character c = rest.charAt(0);

				if (children.containsKey(c)) {
					return children.get(c).contains(rest);
				}

				return false;
			}
		}
	}
}
