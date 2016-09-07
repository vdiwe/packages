

// -----( IS Java Code Template v1.2
// -----( CREATED: 2016-08-24 14:44:40 EDT
// -----( ON-HOST: MTUDU-W7.na.ds.lexmark.com

import com.wm.data.*;
import com.wm.util.Values;
import com.wm.app.b2b.server.Service;
import com.wm.app.b2b.server.ServiceException;
// --- <<IS-START-IMPORTS>> ---
// --- <<IS-END-IMPORTS>> ---

public final class vachas

{
	// ---( internal utility methods )---

	final static vachas _instance = new vachas();

	static vachas _newInstance() { return new vachas(); }

	static vachas _cast(Object o) { return (vachas)o; }

	// ---( server methods )---




	public static final void createISpackage (IData pipeline)
        throws ServiceException
	{
		// --- <<IS-START(createISpackage)>> ---
		// @sigtype java 3.5
		// [i] field:0:required name
		// [o] field:0:required status
		// pipeline
		IDataCursor pipelineCursor = pipeline.getCursor();
			String	name = IDataUtil.getString( pipelineCursor, "name" );
			
			IData
		
			IDataUtil.put( pipelineCursor, "status", "status" );
		pipelineCursor.destroy();
		
			
		// --- <<IS-END>> ---

                
	}
}

