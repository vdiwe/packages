// This file must be included from within a <SCRIPT> tag 

function createTree(modelList, modelTreeList, models, ModelID, ModelVersion)
{
	var previous;
	var node;
	var element = "";
	var Nodes = ModelID.split("/");
	for (var lp=0; lp<Nodes.length-1;lp++)
	{
		element = element + Nodes[lp];
		var modelTree = getServerTree(element, modelList, modelTreeList);
		if (modelTree != null)
		{
			previous = modelTree;
			if (lp < Nodes.length)
			{
				element = element + '/';
			}
		}
		else {
			modelList[modelList.length] = element;
			if (lp > 0)
			{
				modelTree = new WebFXTreeItem(Nodes[lp],	"list-all-process.dsp?mid=" + element + "/" + "?_ALL_", null, webFXTreeConfig.folderIcon,webFXTreeConfig.openFolderIcon);
			}
			else
			{
				modelTree = new WebFXTreeItem(Nodes[lp],	"list-all-process.dsp?mid=" + element + "/" + "?_ALL_", null, webFXTreeConfig.BPMfolder,webFXTreeConfig.BPMfolder, webFXTreeConfig.linkClass);
			}	
			modelTreeList[modelTreeList.length] = modelTree;
			if (previous == null)
			{
				models.add(modelTree);
			}
			else {
				previous.add(modelTree);
			}
			previous = modelTree;
			if (lp < Nodes.length)
			{
				element = element + '/';
			}

		}
	}
	var model = getServerTree(ModelID, modelList, modelTreeList);
	if (model == null)
	{
		model = new WebFXTreeItem(Nodes[Nodes.length-1], "list-all-process.dsp?mid=" + ModelID + "?_ALL_", null, 
				webFXTreeConfig.BPMmodel,webFXTreeConfig.BPMmodel, webFXTreeConfig.linkClass);
		modelList[modelList.length] = ModelID;
		modelTreeList[modelTreeList.length] = model;
		if (previous != null) {
			previous.add(model);
		}
	}	
}


var models = new WebFXTree("Processes", 
	"list-all-process.dsp?mid=_ALL_?_ALL_",
	null, webFXTreeConfig.BPMprocess, webFXTreeConfig.BPMprocess, webFXTreeConfig.propertyClass);

var modelList = new Array;
var modelTreeList = new Array;

%invoke wm.prt.dashboard:getProcessTree%
%loop modelNodes% 
createTree(modelList, modelTreeList, models, '%value ModelID%', '%value ModelVersion%');
%endloop%
%endinvoke%

w(models);