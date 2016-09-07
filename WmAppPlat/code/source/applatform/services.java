
package applatform;

// -----( IS Java Code Template v1.2
// -----( CREATED: 2014-08-12 11:48:58 EDT
// -----( ON-HOST: MCRBURGETT.eur.ad.sag

import com.wm.data.*;
import com.wm.app.b2b.server.Manifest;
import com.wm.app.b2b.server.Server;
import com.wm.app.b2b.server.BaseService;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
import com.wm.app.b2b.util.ServerIf;
import com.wm.app.b2b.server.Package;
import com.wm.app.b2b.server.PackageManager;
import com.wm.app.b2b.server.PackageStore;
import com.wm.app.b2b.server.ACLManager;
import com.softwareag.util.IDataMap;
import com.wm.lang.ns.NSInterface;
import com.wm.lang.ns.NSName;
import com.wm.lang.ns.NSNode;
import com.wm.lang.ns.NSRecord;
import com.wm.lang.ns.NSService;
import com.wm.lang.ns.NSSignature;
import com.wm.util.Name;
import com.softwareag.applatform.pls.is.osgi.MethodMetadataImpl;
import com.softwareag.applatform.pls.is.osgi.Metadata2Signatures;
import com.softwareag.applatform.pls.is.osgi.OsgiService;
import java.util.ArrayList;
import java.util.Arrays;
// --- <<IS-END-IMPORTS>> ---

public final class services
{
    // ---( internal utility methods )---

    final static services _instance = new services();

    static services _newInstance() { return new services(); }

    static services _cast(Object o) { return (services)o; }

    // Keep track of the current WmAppPlat IS package version
    static String wmAppPlatVersion = null;

    // ---( server methods )---
    
    public static final void startup(IData pipeline) throws ServiceException {
        // --- <<IS-START(startup)>> ---
        // @sigtype java 3.5
    	try {
    		//System.err.println("Starting WmAppPlat package");
    		initServiceACLs(new String[]{"applatform.services:registerService", "applatform.services:unregisterService"});
    	} catch (Exception e) {
    		Server.logError(e);
    	} 
        // --- <<IS-END>> ---
    	
    }
    
    public static final void shutdown(IData pipeline) throws ServiceException {
        // --- <<IS-START(shutdown)>> ---
        // @sigtype java 3.5
    	
    	try {
    		//System.err.println("Stopping WmAppPlat package");
    		
    	} catch (Exception e) {    		
    		Server.logError(e);    		
    	}
        // --- <<IS-END>> ---

    }

    public static final void registerService (IData pipeline)
        throws ServiceException
    {
        // --- <<IS-START(registerService)>> ---
        // @sigtype java 3.5
        // [i] field:0:required serviceInterface
        // [i] field:0:required serviceName
        // [i] field:0:required servicePackage
        // [i] record:0:required serviceMetadata
    	// [i] field:0:optional debug
        IDataMap pipeMap = new IDataMap(pipeline);
        IData metaData = pipeMap.getAsIData("serviceMetadata"); //Constants.KEY_PIPELINE_METADATA

        String fullSvcName = nameFromPipe(pipeMap);
        if ( fullSvcName == null || fullSvcName.length() == 0 ) {
            Server.logError((String)null, "serviceInterface/Name inputs are required");
            throw new ServiceException("serviceInterface/Name inputs are required");
        }

        String svcPkgName = pipeMap.getAsString("servicePackage"); //Constants.KEY_IS_SVC_PKG
        if ( svcPkgName == null || svcPkgName.length() == 0 ) {
            Server.logError((String)null, "servicePackage input is required");
            throw new ServiceException("servicePackage input is required");
        }
        boolean debug = pipeMap.getAsBoolean("debug", Boolean.FALSE);

        try {
            createAndRegister(fullSvcName, svcPkgName, metaData, debug);
        }
        catch ( Exception e ) {
            Server.logError(e);
            throw new ServiceException(e);
        }

        // --- <<IS-END>> ---

    }

    public static final void unregisterService (IData pipeline)
            throws ServiceException
        {
            // --- <<IS-START(unregisterService)>> ---
            // @sigtype java 3.5
            // [i] field:0:required servicePackage
            // [i] field:0:required fullSvcName
    	    // [i] field:0:required bundleSymbolicName
    	    // [i] field:0:required bundleVersion
    	    // [i] field:0:optional debug
            IDataMap pipeMap = new IDataMap(pipeline);
            String packageName = getRequiredString("servicePackage", pipeMap); //Constants.KEY_IS_SVC_PKG
            String fullSvcName = getRequiredString("fullSvcName", pipeMap); //Constants.KEY_FULL_SVC_BINDING_NAME
            String symbName = getRequiredString("bundleSymbolicName", pipeMap); //Constants.KEY_PIPELINE_SYMB_NAME
            String bundleVersion = getRequiredString("bundleVersion", pipeMap); //Constants.KEY_PIPELINE_BUNDLE_VERSION
            boolean debug = pipeMap.getAsBoolean("debug", Boolean.FALSE);

            try {
            	unregister( fullSvcName, packageName, symbName, bundleVersion, debug );
            }
            catch ( Exception e ) {
                Server.logError(e);
                throw new ServiceException(e);
            }

            // --- <<IS-END>> ---

        }


    // --- <<IS-START-SHARED>> ---

    private static final String PARENT_PACKAGE_NAME = "WmAppPlat";
    //  manifest dependency API requires 'parent package'; currently ignored
    private static final String DUMMY_PARENT_PACKAGE_NAME = "Default";

    private static String nameFromPipe(IDataMap inPipe) {
        String ifcName = inPipe.getAsString("serviceInterface", "service.pojo.test");
        String svcName = inPipe.getAsString("serviceName", "concat");
        return ifcName + ":" + svcName;
    }


    private static void unregister(String inSvcName, String inPkgName, String symbName, String bundleVersion, boolean debug) throws Exception {
    	ensurePackageExists(inPkgName, debug);
    	if (debug) log(String.format("Getting service node '%s' in package '%s'",inSvcName, inPkgName));
        Object svcNode = getNode(inSvcName);
        if ( svcNode == null ) {
        	if (debug) log(String.format("Service node '%s' does not exist", inSvcName));
        	return;
        }
    	if ( shouldRemoveServiceBinding(svcNode, symbName, bundleVersion, debug) && removeServiceNode(svcNode, inSvcName, inPkgName, debug) ) {
            	PackageManager.loadPackage(inPkgName, true, false);
        } else {
        	if (debug) log(String.format("Service node '%s' not removed ", inSvcName));
        }

    }

    private static boolean shouldRemoveServiceBinding(Object svcNode, String symbName, String bundleVersion, boolean debug) {
    	if ( svcNode instanceof BaseService) {
    		IData svcData = ((BaseService)svcNode).getAsData();
    		IDataMap svcMap = new IDataMap(svcData);
    		IDataMap metadataMap = svcMap.getAsIDataMap("metadata"); //Constants.KEY_AP_SVC_METADATA
    		if ( metadataMap != null) {
    			String csrSymbName = metadataMap.getAsString("Bundle-SymbolicName"); //Constants.KEY_SERVICE_BUNDLE_SYMBOLIC_NAME
    			String csrBundleVersion = metadataMap.getAsString("Bundle-Version"); //Constants.KEY_SERVICE_BUNDLE_VERSION
    			if (debug) log(String.format("customer bundle: %s/%s, client-binding: %s/%s",
    					symbName, bundleVersion, csrSymbName, csrBundleVersion));
    			// if service binding (csr) has no bundle symbolic name, return true. It's a pre-9.10 generated binding that should be recreated later
    			// (Re-deploying bundles is part of our migration strategy)
    			// Otherwise, the version and symbolic name must match
    			return ( csrSymbName == null || ( symbName.equals(csrSymbName) && bundleVersion.equals(csrBundleVersion)) );
    		}

    	}
    	return false;
    }

    private static void createAndRegister(String inSvcName, String inPkgName, IData inMetaData, boolean debug) throws Exception {
    	ensurePackageExists(inPkgName, debug);
    	if (debug) log(String.format("Getting service node '%s' in package '%s'",inSvcName, inPkgName));
        Object svcNode = getNode(inSvcName);
        if ( svcNode == null ) {
        	if (debug) log(String.format("Creating service node '%s' in package '%s'", inSvcName, inPkgName));
            createNewServiceNode(inSvcName, inPkgName, inMetaData, debug);
        }
        else {
            updateExistingServiceNode(svcNode, inSvcName, inPkgName, inMetaData, debug);
        }
    	PackageManager.loadPackage(inPkgName, true, false);
    }
    
    /** Verify the customer package exists */
    private static void ensurePackageExists(String inPkgName, boolean debug) throws Exception {
        Package returnPkg = PackageManager.getPackage(inPkgName);
        if ( returnPkg == null ) {
            makePackage(inPkgName, debug);
            returnPkg = PackageManager.getPackage(inPkgName);
        }
        addAppPlatDependency(returnPkg, DUMMY_PARENT_PACKAGE_NAME, PARENT_PACKAGE_NAME, getGatewayPackageVersion(), debug);
    }

    private static void makePackage(String inName, boolean debug) throws Exception {
        IDataMap pipeMap = new IDataMap();
        pipeMap.put("package", inName);
        IDataMap resultMap = new IDataMap();

    	if (debug) log(String.format("Creating package: %s",inName));
        IData resultData = Service.doInvoke(ServerIf.IFC_PACKAGES, "packageCreate", pipeMap.getIData());
        resultMap = new IDataMap(resultData);
        int rc = resultMap.getAsInteger("code");
        String message = resultMap.getAsString("message");
        if ( rc == ServerIf.PKG_SERVICE_SUCCESS_CODE ) {
            pipeMap = new IDataMap();
            pipeMap.put("package", inName);
            log(String.format("Activating package: %s",inName));
            resultData = Service.doInvoke(ServerIf.IFC_PACKAGES, "packageActivate", pipeMap.getIData());
            resultMap = new IDataMap(resultData);
            rc = resultMap.getAsInteger("code");
            if ( rc != ServerIf.PKG_SERVICE_SUCCESS_CODE) {
            	throw new RuntimeException( String.format( "%s:%s for %s code(%s).  %s",
          			  ServerIf.IFC_PACKAGES,"packageActivate",inName, rc, message));
            }
        } else {
        	throw new RuntimeException( String.format( "%s:%s for %s code(%s).  %s",
        			  ServerIf.IFC_PACKAGES,"packageCreate",inName, rc, message));
        }

    }

    private static void addAppPlatDependency(Package inPkg, String inParentDummyName, String inParentPackageName,
    		     String inParentVersion, boolean debug) {
        Manifest mani = inPkg.getManifest();
        String[] requires = mani.getRequiresAsStr();
        boolean update = true;
        if ( requires != null ) {
        	for ( String require : requires ) {
        		if ( require.startsWith( PARENT_PACKAGE_NAME) ) {
        			update = !require.equals(getGatewayPackageVersion());
        			if ( update) {
        				if (debug) log(String.format("addAppPlatDependency() removing outdated '%s' dependency from package '%s'", require, inPkg.getName()));
	        			mani.delDependency( require );
	        	        break;
        			}
        		}
        	}
        }
        if ( update) {
			StringBuffer msgBuff = new StringBuffer();
	        mani.addDependency(inParentDummyName, getGatewayPackageVersion(), msgBuff);
	        if (debug) log(String.format("addAppPlatDependency() applying '%s' dependency to package '%s'. Details: %s", getGatewayPackageVersion(), inPkg.getName(), msgBuff.toString()));

	        PackageManager.savePackageConfiguration(inPkg);
        }
    }

    private static void createNewServiceNode(String inSvcName, String inPkgName, IData inMetaData, boolean debug) throws Exception {
        guaranteeInterfacePath(inPkgName, inSvcName);
        IDataMap pipeMap = new IDataMap();
        addServiceDetails(pipeMap, inSvcName, inPkgName, inMetaData);
        if (debug) log(String.format("makeNode %s and add to package %s",inSvcName, inPkgName));
        Service.doInvoke(ServerIf.IFC_NS, "makeNode", pipeMap.getIData());
        NSName name = NSName.create(inSvcName);
        Package pkg = PackageManager.getPackage(inPkgName);
        pkg.getStore().addToNode(name, PackageStore.NDF_FILE, pipeMap.getIData());
        
        String xAcl = getExecuteACLFromAllowedRoles(new IDataMap(inMetaData), debug);        
        String rMsg = updateACLsForService( inSvcName, 
        		ACLManager.WEBM_DEVELOPERS_ACL, //ACLManager.WEBM_ADMINISTRATORS_ACL,  // browse
        		xAcl,  // execute 
        		null, /*ACLManager.WEBM_INTERNALDEV_ACL,*/ // read
        		null, /*ACLManager.WEBM_INTERNALDEV_ACL,*/ // write
        		debug); 
                
        PackageManager.loadPackagePartial(inPkgName, new NSName[] { name });

    }
    
    /**
     * Get the first role that is actively used in Integration Server and use this as the Execute ACL
     */
    private static String getExecuteACLFromAllowedRoles(IDataMap metadataMap, boolean debug) {
    	
    	String xAcl = null;
    	String[] roles = (String[])metadataMap.getAsStringArray("allowedRoles"); //Constants.KEY_SERVICE_ALLOWED_ROLES
    	int sz = ( roles == null ? 0 : roles.length);
    	if ( sz > 0) {
    		for ( String role : roles) {
    			if ( ACLManager.getGroup(role) != null) {
    				xAcl = role;
    				break;
    			}
    		}
    		
    		if ( xAcl == null) {
    			if (debug) log(String.format("NO IS ACL exists for designated roles:  %s",Arrays.asList(roles)));
    		}
    	} 
    	return xAcl;
    }
    
    /**
     * Updates the ACL for the specified service
     * Null values imply intent to reset back to the 'Inherited' default behavior for the service
     */
    private static String updateACLsForService(String svcName, String browseAcl, String xAcl, String rAcl, String wAcl, boolean debug) throws Exception {    
    	
    	String rMsg = null;
    	IData getNodeOutput = null;
    	IDataMap resultMap = null;
    	
    	IDataMap serviceMap = getServiceInfo(svcName);
    	String origBrowseAcl =  serviceMap.getAsString(ServerIf.GET_SVCINFO_BROWSEACLGROUP);
    	String origReadAcl =  serviceMap.getAsString(ServerIf.GET_SVCINFO_READACLGROUP);
    	String origWriteAcl =  serviceMap.getAsString(ServerIf.GET_SVCINFO_WRITEACLGROUP);
    	String origExecuteAcl =  serviceMap.getAsString(ServerIf.GET_SVCINFO_ACLGROUP);
    	
    	ArrayList<String> changes = new ArrayList<>();
    	if ( !aclChanged( origBrowseAcl, browseAcl, changes )) {
    		browseAcl = origBrowseAcl; 
    	} 
    	if ( !aclChanged( origReadAcl, rAcl, changes )) {
    		rAcl = origReadAcl;
    	}
    	if ( !aclChanged( origWriteAcl, wAcl, changes )) {
    		wAcl = origWriteAcl;
    	}
    	if ( !aclChanged( origExecuteAcl, xAcl, changes )) {
    		xAcl = origExecuteAcl;
    	}
    	
    	if ( changes.size() > 0 ) {
    	
    		IDataMap pipeMap = serviceMap;
    		
	        pipeMap.put(ServerIf.SET_SVCINFO_SERVICE, svcName);
	        pipeMap.put(ServerIf.SET_SVCINFO_ACLGROUP, xAcl);
	        
	        // enforce even if it's not a top level service	        
	        // pipeMap.put(ServerIf.SET_SVCINFO_INTERNAL_ACL_CHECK, "true");
	        pipeMap.put(ServerIf.SET_SVCINFO_WRITEACLGROUP, wAcl);
	        pipeMap.put(ServerIf.SET_SVCINFO_READACLGROUP, rAcl);
	        pipeMap.put(ServerIf.SET_SVCINFO_BROWSEACLGROUP, browseAcl);

	        getNodeOutput = Service.doInvoke(ServerIf.IFC_SERVICES, ServerIf.SVC_SET_SERVICE_INFO, pipeMap.getIData());
	        resultMap = new IDataMap(getNodeOutput);
	        rMsg = resultMap.getAsString("message");
	        if ( rMsg != null && rMsg.startsWith("com.wm.app.b2b.server.ServiceException")) throw new ServiceException(rMsg);
	        
	        if (debug) log(String.format("ACL update: browse(%s), execute(%s), read(%s), write(%s).  'aclAssign' response msg: %s",
	        		browseAcl, xAcl, rAcl, wAcl, rMsg));
    	}
        return rMsg;

    	
    }
    
    private static boolean aclChanged(String origAcl, String newAcl, ArrayList<String> changes) {
    	boolean changed = false;
    	if ( "Default".equals(origAcl)) {
    		origAcl = null;
    	}
    	if ( origAcl == null ) {
    		if (newAcl != null) {
    			changed = true;
    			
    		}
    	} else {
    		changed = !(origAcl.equals(newAcl));
    	}
    	if ( changed ) {
    		changes.add( String.format("%s->%s",origAcl,newAcl));
    	}
    	return changed;
    }
    
    private static IDataMap getServiceInfo(String svcName) throws Exception {
    	
    	IDataMap pipeMap = new IDataMap();
    	pipeMap.put(ServerIf.GET_SVCINFO_SERVICE, svcName);
    	IData result = Service.doInvoke(ServerIf.IFC_SERVICES, ServerIf.SVC_GET_SERVICE_INFO, pipeMap.getIData());
    	return new IDataMap(result);
    }

    private static void updateExistingServiceNode(Object inSvcNode, String inSvcName, String inPkgName, IData inMetaData,
    		   boolean debug) throws Exception {
        if ( inSvcNode instanceof NSNode ) {
        	if (debug) log(String.format("updateExistingServiceNode() -deleting node '%s' in package '%s'", inSvcName, inPkgName));
        	deleteNode(inPkgName, inSvcName);
        	if (debug) log(String.format("updateExistingServiceNode() -creating node '%s' in package '%s'", inSvcName, inPkgName));
            createNewServiceNode(inSvcName, inPkgName, inMetaData, debug);
        }
        else {
        	if (debug) log(String.format("updateExistingServiceNode() - found a node that's not a NSNode: ", inSvcNode));
        }
    }

    private static boolean removeServiceNode(Object inSvcNode, String inSvcName, String inPkgName, boolean debug) throws Exception {
        if ( inSvcNode instanceof OsgiService ) {
        	
        	IData data = ((OsgiService)inSvcNode).getAsData();
        	IDataMap mapData = new IDataMap(data);        	
        	IDataMap metadataMap = mapData.getAsIDataMap(OsgiService.METADATA_KEY);
        	// delete's ACLs too
        	deleteNode(inPkgName, inSvcName);
        	return true;
        }
        return false;
    }

    private static void guaranteeInterfacePath(String inPkgName, String inSvcName) throws Exception {
        Package pkg = PackageManager.getPackage(inPkgName);
        NSName name = NSName.create(inSvcName);
        //  first, make sure directories exist in the file system
        pkg.getStore().getNodePath(name).mkdirs();
        //  then, make sure interface nodes exist in the namespace for each directory
        Name[] nsPath = name.getInterfacePath();
        String nodeName = "";
        for ( Name nextPathElem : nsPath ) {
            if ( nodeName.isEmpty() ) {
                nodeName += nextPathElem.toString();
            }
            else {
                nodeName += "." + nextPathElem.toString();
            }
            Object nodeData = getNode(nodeName);
            if ( nodeData == null ) {
                nodeData = makeInterfaceNode(inPkgName, nodeName);
            }
        }
    }

    private static void deleteNode(String inPkgName, String inNodeName) throws Exception {
        IDataMap pipeMap = new IDataMap();
        pipeMap.put(NSNode.KEY_NSN_NSNAME, inNodeName);
        pipeMap.put(NSNode.KEY_NSN_PACKAGE, inPkgName);
        Service.doInvoke(ServerIf.IFC_NS, "deleteNode", pipeMap.getIData());
    }

    private static Object getNode(String inNodeName) throws Exception {
    	return getNodeServiceInvoke(inNodeName);
    }

    private static Object getNodeServiceInvoke(String inNodeName) throws Exception {
        IDataMap pipeMap = new IDataMap();
        pipeMap.put("name", inNodeName);
        IData getNodeOutput = Service.doInvoke(ServerIf.IFC_NS, "getNode", pipeMap.getIData());
        IDataMap resultMap = new IDataMap(getNodeOutput);
        return resultMap.get("node");

    }

    private static Object makeInterfaceNode(String inPkgName, String inNodeName) throws Exception {
        IDataMap pipeMap = new IDataMap();
        pipeMap.put(NSNode.KEY_NSN_NSNAME, inNodeName);
        pipeMap.put(NSNode.KEY_NSN_PACKAGE, inPkgName);
        pipeMap.put(NSNode.KEY_NSN_TYPE, NSInterface.TYPE);
        IData makeNodeOutput = Service.doInvoke(ServerIf.IFC_NS, "makeNode", pipeMap.getIData());
        IDataMap resultMap = new IDataMap(makeNodeOutput);
        return resultMap.get("node");
    }

    private static void addServiceDetails(IDataMap inMap, String inSvcName, String inPkgName, IData inMetaData) throws Exception {
        inMap.put(NSService.KEY_NSS_SIG, metadata2Signature(inMetaData));
        inMap.put(OsgiService.METADATA_KEY, inMetaData);
        inMap.put(NSNode.KEY_NSN_PACKAGE, inPkgName);
        inMap.put(NSNode.KEY_NSN_NSNAME, inSvcName);
        inMap.put("is_public", Boolean.TRUE);
        inMap.put(NSNode.KEY_NSN_TYPE, NSService.TYPE_KEY);
        inMap.put(NSService.KEY_NSS_TYPE, OsgiService.NSTYPE);
    }

    private static Object metadata2Signature(IData inMetaData) {
        MethodMetadataImpl metadataImpl = new MethodMetadataImpl();
        metadataImpl.setFromData(inMetaData);
        NSRecord inSig = Metadata2Signatures.createInputSig(metadataImpl);
        NSRecord outSig = Metadata2Signatures.createOutputSig(metadataImpl);
        return new NSSignature(inSig, outSig);
    }

    /**
     * Return the formatted package version string for the WmAppPlat package.
     */
    private static String getGatewayPackageVersion() {
    	if ( wmAppPlatVersion == null) {
    		String packageVersion = PARENT_PACKAGE_NAME+";9.10.0";
	    	try {
	    		Package pkg = PackageManager.getPackage(PARENT_PACKAGE_NAME);
	    		if ( pkg != null) {
	    			packageVersion = formattedPackageName(PARENT_PACKAGE_NAME, pkg.getVersion());
	    		}
	    	} catch (Exception e) { }
	    	wmAppPlatVersion = packageVersion;
    	}

    	return wmAppPlatVersion;
    }

    /**
     * Create a string that meets the expected format for a required IS package dependency as it exists in the manifest.
     */
    private static String formattedPackageName(String packageName, String rawVersion) {
    	String version = rawVersion;
    	if ( rawVersion != null) {
    		String[] pieces = rawVersion.split( "\\.");
    		StringBuilder builder = new StringBuilder();
    		for ( int idx = 0; idx < 3; idx++) {
    			if (idx>0) builder.append('.');
    			builder.append(pieces[idx].trim());
    		}
    		version = builder.toString();
    	}
    	return packageName+";"+version;
    }

    private static String getRequiredString(String key, IDataMap pipeMap) throws ServiceException {
    	String value = pipeMap.getAsString(key);
    	if ( value == null || value.length() == 0) {
    		String msg = String.format("%s is required input parameter", key);
    		throw new ServiceException(msg);
    	}
    	return value;
    }

    private static void log( String message) {
    	System.out.println(String.format(">>>[AppPlat Gateway] %s", message));
    }

    /**
     * Permissions for those services that are used by WmAppPlat
     */
    private static void initServiceACLs(String[] apServices) {

		if ( apServices != null) {
			for ( String apService : apServices) {
		    	try {
		    		String rMsg = updateACLsForService( apService, 
	            		ACLManager.WEBM_ADMINISTRATORS_ACL, // browse
	            		ACLManager.INTERNAL_ACL,  // execute 
	            		null, /*ACLManager.WEBM_INTERNALDEV_ACL,*/ // read
	            		null, /*ACLManager.WEBM_INTERNALDEV_ACL,*/ // write
	            		false); 
	
	
		    	} catch (Exception e) {
		    		Server.logError(e);	
		    	}
			}
		}
    }
    
    // --- <<IS-END-SHARED>> ---
}
