package com.basic4gl.compiler;

import com.basic4gl.runtime.plugin.PluginStructureManager;
import com.basic4gl.runtime.types.Constant;

public interface PluginManager {

	public void createVMFunctionSpecs();

	public PluginStructureManager getStructureManager();

	public Constant findConstant(String name);
}
