/*
   New Perspectives on XML
   Tutorial 10
   Case Problem 4

   Filename: library.js

   Global Variables:
   DOMPID
      An array contain the program IDs of MSXML ActiveX Objects for creating
      XML documents

   FreeThreadPID
      An array contain the program IDs of MSXML ActiveX Objects for creating
      free-threaded XML documents

   TemplatePID
      An array contain the program IDs of MSXML ActiveX Objects for creating
      XML template documents

   Functions List:
   getPID(pArray)
      Returns the most recent program ID supported by the current browser.

   loadDoc(document, file)
      Synchronously loads an XML or XSLT file into the document object

   extractFName(path)
      Extracts the filename from a path string.

   removeWhiteSpaceNodes(node)
      Removes all white space text nodes contained within the specified node.

*/
       
       var IE = window.ActiveXObject ? true:false;
       var MOZ = document.implementation.createDocument ? true:false;



       var xmlFile = "jazz.xml";  // Source XML document is xmlFile
       var xsltFile = "jazz.xsl";  // Start with the basic JAZZ.XSL file
       var xsltFile2 = "";
       var xmlDoc;
       var xsltDoc; 
       var xmlDoc2;   // Temporary structure XML document for buildind the new titile and track
       var xsltDoc2;  // Temporary structure XSLT 
       
       
       var xmlDocSave;
       
       var titleElem = document.getElementById("titlelist");
       var trackElem = document.getElementById("tracklist");
       var newtitle;  // Global temporary structure
       
       var selectValue  = "showall";   // selection value for Show all Specials 
       var currentSelect = "showall";   // selection value for Show all Specials
       var currentView = "showall";  // Sort direction for ascending or descending
             
        var masterTitle;   // Track the master Title list from the root node
        var masterCD;  // Track the master Title list from the CD element 
        var masterTitleclone;  // Track the master Title list from the root node as  clone
        var masterCDclone;  // Track the master Title list from the CD element as a clone
        
       
       
       
var DOMPID =        ["Msxml2.DOMDocument.5.0", 
                     "Msxml2.DOMDocument.4.0",
                     "Msxml2.DOMDocument.3.0", 
                     "MSXML2.DOMDocument", 
                     "Microsoft.XMLDOM"];

var FreeThreadPID = ["Msxml2.FreeThreadedDOMDocument.5.0",
                     "Msxml2.FreeThreadedDOMDocument.4.0",
                     "Msxml2.FreeThreadedDOMDocument.3.0"];

var TemplatePID =   ["Msxml2.XSLTemplate.5.0",
                     "Msxml2.XSLTemplate.4.0",
                     "Msxml2.XSLTemplate.3.0"];
                 
var HTTPPID =       ["Msxml2.XMLHttp.5.0", 
                     "Msxml2.XMLHttp.4.0",
                     "Msxml2.XMLHttp.3.0", 
                     "Msxml2.XMLHttp", 
                     "Microsoft.XMLHttp"];              

function getPID(pArray) {
   var PIDStr = "";
   var PIDFound = false;
   for (i=0; i<pArray.length && !PIDFound; i++) {
      try {
         var objectXML=new ActiveXObject(pArray[i]);
         PIDStr=pArray[i];
         PIDFound=true;
      } catch (objException) {
      }
   }
   return PIDStr;
}

function loadDoc(document, file) {
   document.async=false;
   document.load(file);
}

function extractFName(path) {
   i=path.lastIndexOf("\\");
   if (i==-1) i=path.lastIndexOf("/");
   return path.substring(i+1);
}

function removeWhiteSpaceNodes(node) {
   var noWhiteSpace = /\S/;
   for (var i=0; i < node.childNodes.length; i++) {
      testNode = node.childNodes[i];
      if (testNode.nodeType==3 && !noWhiteSpace.test(testNode.nodeValue)) {
         node.removeChild(testNode);
         i--;
      }
      if (testNode.nodeType==1) {
         removeWhiteSpaceNodes(testNode);
      }
   }
}

/*
* 
* 
*/
function createXDoc(xFile, PID) {

   var xDoc;

   if (IE) {
        xDoc = new ActiveXObject(getPID(PID));
   } else if (MOZ) {  // Mozilla Firefox 
        xDoc = document.implementation.createDocument("","",null);
   }
   loadDoc(xDoc, xFile);

   return xDoc;
}


/*
 * 
 * This function transform source documents and returns the result document as text
 */
function runTransform(xDoc, xsltDoc) {

    var resultStr;
    var resultDoc;

    if (IE) {  // Internet Explorer            
        resultStr = xDoc.transformNode(xsltDoc);
    } else if (MOZ) {  // Mozilla Firefox

        var xProcessor = new XSLTProcessor();
        xProcessor.importStylesheet(xsltDoc);
        resultDoc = xProcessor.transformToDocument(xDoc);
        var xSerial = new XMLSerializer();
        resultStr = xSerial.serializeToString(resultDoc);
    }
    return resultStr;
}


       /*
        * Function:  TransformDoc()
        * Purpose: Transforms the output for HTML results
        * 
        * @returns {undefined}
        */
    
       function TransformDoc() {
           
           var cdTable = document.getElementById("titlelist");
           

           if (IE) {
               xTemplate.stylesheet=xsltDoc;
               xProcessor = xTemplate.createProcessor();
               //  xProcessor.input = xmlDoc; //was here
               xProcessor.input = xmlDoc;
              // filterGrants(xProcessor);  // set the style sheet parameter value
              // xProcessor.input = xmlDoc;
               xProcessor.transform();
               
               cdTable.innerHTML = xProcessor.output;
           }
           else if (MOZ) { // if (MOZ)

               //var XSLTProc= new XSLTProcessor();  // new XSLTProcessor();
               // We know we can use XMLHttpRequest() to transform XSLT
               var xProcessor = new XSLTProcessor();
               
           //    var xProcessor = Components.classes["@mozilla.org/document-transformer;1?type=xslt"]
           //               .createInstance(Components.interfaces.nsIXSLTProcessor);
                  
               xProcessor.importStylesheet(xsltDoc);  // Import XSL doc, for DOM Node
                 
              // filterGrants(xsltDoc);  // set the style sheet parameter value
             //  filterGrants(xProcessor);  // set the style sheet parameter value
               var resultDoc = xProcessor.transformToFragment(xmlDoc, document);
               
               var Xserial = new XMLSerializer();
               var Xstr = Xserial.serializeToString(resultDoc);     // xmlDoc, resultDoc
               
               cdTable.innerHTML = Xstr;
               
           }
       }




/*
 *  This functions shows the current Special List of CD Titles
 *  The button acts as a toggle to Show or Hide the Special Listing
 * 
 */
function showAll() {

    var trackElem = document.getElementById("tracklist");
    var showElem = document.getElementById("showall");

    // We can track the initial count and compare

    if (xmlDoc.activeElement.childElementCount == 3)  {  // Initial count is 3 nodes
        
        
        xmlFile = "jazz.xml";
        xsltFile = "jazz.xsl";
        xmlDoc = createXDoc(xmlFile, DOMPID);
        xsltDoc = createXDoc(xsltFile, DOMPID);        
        
        
        
    } else {
        
        // Then we have added some CD Title, so use xmlDocSave
        // We can do some extra work here if needed
        // NOP
    }

/*
 * 
           if (selectValue == currentSelect) {
               if (currentOrder == "ascending") currentOrder = "descending";
               else currentOrder="ascending";
           } else if (selectValue != currentSelect) currentSelect = selectValue;
 */    
      
    // Not necessary to have currentSelect since we only have two values to flip
    // This is to save for future logic or programs
    if (currentView == currentSelect) {
        

        showElem.innerHTML = "Hide Special CD List";
        trackElem.innerHTML = runTransform(xmlDoc, xsltDoc);
        currentView = "hideall";


        } else  { // Remove the Special Listing
            // if (selectValue != currentSelect) 

            showElem.innerHTML = "Show Special CD Titles";
            trackElem.innerHTML = "";  // Blank the Special List
            currentView = "showall";
    }
               

   // trackElem.innerHTML = runTransform(xmlDoc, xsltDoc);
}


/*
* Function:  addCDTitle()
*  Add function to add a new CD Title record into the source document
*  by using a cloning and appendChild method
* 
*/
function addCDTitle() {
    
// Will need logic to test IE and MOZ
//
    var masterTitle=xmlDoc2.getElementsByTagName("specials");
    var masterCD=xmlDoc2.getElementsByTagName("cd");
    // masterTitle;   // Track the master Title list from the root node
    // masterCD;  // Track the master Title list from the CD element 
    
    // masterTitleclone=masterTitle.cloneNode(true); // Track the master Title list from the root node as  clone
    // masterCDclone=masterCD.cloneNode(true);
     
     
    

    var titleElem = document.getElementById("titlelist");
    //var oldCD=xmlDoc2.getElementsByTagName("cd")[0];
    //var newCD=oldCD.cloneNode(false);  // works
    //  Capture values from the user's input 
    /*
     *   We need to create document fragments
     *   We have the base segment named "cd"
     *   
     *   Under the CD element
     *   We need to have a nodeValue = title
     *   Then we need to create two 
     */
   
   // var newArtist = newCD.createElement("artist");  // maybe clone should be xmlDoc
   // var newPrice = newCD.createElement("price");
   
    var titleTxt = document.dataform.title.value;
    var artistTxt = document.dataform.artist.value;
    var priceTxt = document.dataform.amount.value;
    
   // var titleT = newCD.createTextNode(titleTxt);   // newCD Title
   // var artistT = newCD.createTextNode(artistTxt);
   // var priceT = newCD.createTextNode(priceTxt);
    
    // newArtist.appendChild(artistT);
    // newPrice.appendChild(priceTxt);
    
    //
    //
    // Create the CD-Title
    newtitle=xmlDoc2.createElement("cd");
    newtitletxt=xmlDoc2.createTextNode(titleTxt);
    newtitle.appendChild(newtitletxt);

    // Create the Artist
    newArtist=xmlDoc2.createElement("artist");
    newarttxt = xmlDoc2.createTextNode(artistTxt);
    newArtist.appendChild(newarttxt);

    // Create the Price for the CD-Title
    newPrice=xmlDoc2.createElement("price");
    newpricetxt=xmlDoc2.createTextNode(priceTxt);
    newPrice.appendChild(newpricetxt);
    
    // Put it together to show
    newtitle.appendChild(newArtist);
    newtitle.appendChild(newPrice);

    //
    
    // Assign to node format
  //  xmlDoc.documentElement.appendChild(titleT);
   // xmlDoc.appendChild(newArtist);
  //  xmlDoc.appendChild(newPrice);

// Bring it all together
    
    
    // Maybe do some cloning here
    
    
    xmlDoc2.documentElement.appendChild(newtitle);
   // xmlDoc.documentElement.appendChild(newCD);  //Clone items
   // //xmlDoc2.documentElement.appendChild(newTrack); 
   
   // Show new title
   titleElem.innerHTML = runTransform(xmlDoc2,xsltDoc2);
   // Try this, other run the two below
//   TransformDoc();
 //  resetForm();

   //oldcd.documentElement.appendChild(clone);

   //resetForm();
}

/*
* Function:  addCDTrack()
*  Add function to add a new CD Title record into the source document
*  by using a cloning method
* 
*/
function addCDTrack() {

    // trackElem is defined as a Global variable for the div section
    // in the main form, adds a new track entry for the CD Title

   var loctrackElem = document.getElementById("titlelist");
   var newTrack = xmlDoc2.createElement("track");

//
// Track name
//newtrk1=xmlDoc.createElement("track")
    var trackTxt = document.dataform.track1.value;
    var lenTxt = document.dataform.trklen.value;
    
    var tracktxt=xmlDoc2.createTextNode(trackTxt);
    newTrack.appendChild(tracktxt);
    // Write out the length attribute
//   newCD.setAttribute("length", document.dataform.length.value); 
// Add the attribute for the length of the track
    newTrack.setAttribute("length",lenTxt);


// Build the unit together with CD Title, Artist, Price, and Track

// <td><input name="track1" id="track1" size="40"  /></td>
// <td><input name="tracklen" id="trklen" size="6"   /></td>
//

  
    newtitle.appendChild(newTrack);   // Append to the lastChild
   // xmlDoc2.getElementsByTagName("cd").appendChild(newTrack); 
   // xmlDoc2.documentElement.appendChild(newTrack);   // getElementsByTagName("cd").appendChild(newTrack); 
   //xmlDoc.documentElement.appendChild(clone);

   loctrackElem.innerHTML = runTransform(xmlDoc2,xsltDoc2);
   // Save it to the real list on the Submit button
   //  trackElem.innerHTML = runTransform(xmlDoc,xsltDoc);

   //oldcd.documentElement.appendChild(clone);

   //resetForm();
}



/*
* The purpose of this function is the new CD title into the special collection list
* NOTE: Last edit here
* 
*/
function mergeCD(){
     

    var iMOZ = window.XMLHttpRequest ? true: false;  // Mozilla or Safari
    
    
    var loctitleElem = document.getElementById("titlelist");
    var loctrackElem = document.getElementById("tracklist");
    var newtitle2 = xmlDoc2.getElementsByTagName("cd");
    
    // Bring it all together
    xmlDoc.documentElement.appendChild(newtitle);
    
    
    loctitleElem.innerHTML = runTransform(xmlDoc,xsltDoc);
    loctrackElem.innerHTML = "";
    // Reset xmlDoc2;
    xmlDocSave=xmlDoc;  //  Save the Master document
    
    if (IE) {
        var reqObj = ActiveXObject(getPID(HTTPPID));
        
         xmlDocSave.save(window.xmlDoc.documentURI.substr(0,window.xmlDoc.documentURI.length - xmlFile.length)+"newjazz.xml");
         
    } else if (iMOZ) {
        var reqObj = new XMLHttpRequest();
        // xmlDocSave.save
        // MOZ Firefox
        window.xDocSave = xmlDoc;
    }
    
    
    initReset();
    // Testing
    showAll();
    
}
/*
* The purpose of this function is to run the selected report and
* run the transformation and show results for a selected stock report
* 
* 
*/
function showReport() {
   var reportElem = document.getElementById("cd_report");
   var reportFile = chooseReport();
   var stock = chooseTitle();

   if (reportFile=="" || stock=="") {
       reportElem.innerHTML="";  // Clear out the output
   }
   else {

       var reportXSLT = createXDoc(reportFile, FreeThreadPID);

       if (IE){
           xTemplate = new ActiveXObject(getPID(TemplatePID));
           xTemplate.stylesheet = reportXSLT; 

           xProcessor = xTemplate.createProcessor();
           xProcessor.input = xmlDoc;
           xProcessor.addParameter("cdlist", xmlDoc.selectNodes(stock));

           xProcessor.transform();

           reportElem.innerHTML = xProcessor.output;
       }
       else if (MOZ) {   // for Mozilla
           xProcessor = new XSLTProcessor();
           xProcessor.importStylesheet(reportXSLT);
           xEval = new XPathEvaluator();
           xNodes = xEval.evaluate(stock,xmlDoc,null,0,null);
           xProcessor.setParameter(null,"cdlist",xNodes);

           resultDoc = xProcessor.transformToDocument(xmlDoc);
           var xSerial = new XMLSerializer();
           var xStr = xSerial.serializeToString(resultDoc);

           reportElem.innerHTML = xStr;
       }
    }  //else main 
}  // showreport


       /*
        * 
        * @returns {undefined}
        * 
        
 **    <div id="titlelist"></div>
 **    <div id="tracklist"></div> 
        */
       function init() {
           
           var titleElem = document.getElementById("titlelist");
           
           xmlDoc = createXDoc("jazz.xml", DOMPID);
           xsltDoc = createXDoc("heading.xsl", DOMPID);
           // xmlDoc2 = createXDoc("jazztmp.xml", DOMPID);
           
           
           if (IE) {
                   titleElem.innerHTML=xmlDoc.transformNode(xsltDoc);
           }
           else if (MOZ){        
/*
 * 
 *                
               var xProcessor = new XSLTProcessor();
               xProcessor.importStylesheet(xsltDoc);  // Import XSL doc, for DOM Node
               filterGrants(xProcessor);  // set the style sheet parameter value
               var resultDoc = xProcessor.transformToFragment(xmlDoc, document);
               var Xserial = new XMLSerializer();
               var Xstr = Xserial.serializeToString(resultDoc);     // xmlDoc, resultDoc
               
               grantTable.innerHTML = Xstr;

 * @returns {String}
 */               
               xProcessor = new XSLTProcessor();
               xProcessor.importStylesheet(xsltDoc);
               var resultFragment = xProcessor.transformToFragment(xmlDoc, document);
               titleElem.appendChild(resultFragment);
           }
           
       }

       /*
        * Main program initiiatpr 
        * 
        */
       function myinit() {
           if (IE) {
               xmlDoc = new ActiveXObject(getPID(DOMPID));
               xmlDoc2 = new ActiveXObject(getPID(DOMPID));
               xsltDoc = new ActiveXObject(getPID(FreeThreadPID));  
               xsltDoc2 = new ActiveXObject(getPID(FreeThreadPID)); 
               xTemplate = new ActiveXObject(getPID(TemplatePID));
           }
           else if (MOZ) {  //if (MOZ)
               
               xmlDoc = document.implementation.createDocument("","",null);
               xmlDoc2 = document.implementation.createDocument("","",null);
               xsltDoc = document.implementation.createDocument("","",null);
               xsltDoc2 = document.implementation.createDocument("","",null);
               
           }
           loadDoc(xmlDoc, xmlFile);
           loadDoc(xmlDoc2, xmlFile);
           loadDoc(xsltDoc, xsltFile);  
           loadDoc(xsltDoc2, xsltFile);  
           
          // No on the initial display TransformDoc(); // Apply transformation
         
       }
       
       
       /*
        * Main program initiiatpr 
        * 
        */
       function initReset() {
           
           var locTitleElem = document.getElementById("titlelist");
           if (IE) {

               xmlDoc2 = new ActiveXObject(getPID(DOMPID));
 
               xsltDoc2 = new ActiveXObject(getPID(FreeThreadPID)); 

           }
           else if (MOZ) {  //if (MOZ)
               
              
               xmlDoc2 = document.implementation.createDocument("","",null);

               xsltDoc2 = document.implementation.createDocument("","",null);
               
           }
           loadDoc(xmlDoc2, xmlFile);
           loadDoc(xsltDoc2, xsltFile);  
           
           // Apply transformation
           locTitleElem.innerHTML = "New CD Title "+ document.dataform.title.value+" added.";
           
           // Reset input form
           document.dataform.title.value = "";
           document.dataform.artist.value = "";
           document.dataform.amount.value = "";            
           document.dataform.track1.value = "";
           document.dataform.trklen.value = "";     

       }       