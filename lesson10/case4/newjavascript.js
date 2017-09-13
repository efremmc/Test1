/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


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
         * 
         * 
         */
        function getDate() {
            
            var labElem = document.getElementById("labtable");
            
            // this.document.activeElement.form[0].value
            // does not work: document.signup.datafile
            // works: this.document.signup[0].value
            xmlFile = extractFName(document.signup[0].value);
            xmlDoc = createXDoc(xmlFile, DOMPID);
            xsltDoc = createXDoc(xsltFile, DOMPID);
            
            labElem.innerHTML = runTransform(xmlDoc, xsltDoc);
        }
        
        /*
         * 
         */
        function addRequest() {
            
            var labElem = document.getElementById("labtable");
            var labIndex;
            
            if (document.signup.lab[0].checked) labIndex = 0;
            else if (document.signup.lab[1].checked) labIndex = 1;
            else if (document.signup.lab[2].checked) labIndex = 2;
            else if (document.signup.lab[3].checked) labIndex = 3;
            else if (document.signup.lab[4].checked) labIndex = 4;
            else if (document.signup.lab[5].checked) labIndex = 5;
            
            var timeIndex = document.signup.time.selectedIndex;
            var group = document.signup.group.value;
            var lab = xmlDoc.getElementsByTagName("lab")[labIndex];
            
            removeWhiteSpaceNodes(lab);
            var slot = lab.childNodes[timeIndex].firstChild.nodeValue;
            
           
            if (slot == "free") {
                
                lab.childNodes[timeIndex].firstChild.nodeValue = group;
                labElem.innerHTML = runTransform(xmlDoc,xsltDoc);
                alert("Reservation placed!");
            } else {
                alert("Slot is already reserved!");
            }
        }


       /*
        * Function:  addGrant()
        *  Add function to add a new Grant record into the source document
        *  by using a cloning method
        * 
        */
       function addGrant() {
           
           var oldGrant=xmlDoc.getElementsByTagName("grant")[0];
           var clone=oldGrant.cloneNode(true);
           var tempCategory = "";
                      
           removeWhiteSpaceNodes(clone);
           //  Capture values from the user's input 
           clone.childNodes[0].firstChild.nodeValue=document.dataform.title.value;
           clone.childNodes[1].firstChild.nodeValue=document.dataform.street.value;
           clone.childNodes[2].firstChild.nodeValue=document.dataform.city.value;
           clone.childNodes[3].firstChild.nodeValue=document.dataform.state.value;
           clone.childNodes[4].firstChild.nodeValue=document.dataform.zip.value;
           clone.childNodes[5].firstChild.nodeValue=document.dataform.amount.value;
           clone.childNodes[6].firstChild.nodeValue=document.dataform.date.value;
           
           // Upon selection, sort by selected option
           /*
            *
            * name="category" /> Culture<br />
              name="category" /> Education<br />
              name="category" /> Human Services
            */
           if (document.dataform.category[0].checked) tempCategory="Culture";
           else if (document.dataform.category[1].checked) tempCategory="Education";
           else if (document.wdataform.category[2].checked) tempCategory="Human Services";
           clone.childNodes[7].firstChild.nodeValue=tempCategory;
                     
           xmlDoc.documentElement.appendChild(clone);
           TransformDoc();
           resetForm();
       }
              
       /*
     
        *  Sort list by selected checkbox
        *  IE specific if IE is interpeted 
        *  Mozilla code is pending....
        *  We use the XSLT URI for the XSLT namespace
        *  We act on the button action to sort
        *  
        *  onclick="TransformDoc()"
        */
       function sortGrants() {
           
           if (IE) {
               
               xsltDoc = new ActiveXObject(getPID(FreeThreadPID));
               loadDoc(xsltDoc, xsltFile);
               var sortNode=xsltDoc.getElementsByTagName("xsl:sort")[0];
           } else if (MOZ) {
               // pending code
               var xNS="http://www.w3.org/1999/XSL/Transform";
               var sortNode=xsltDoc.getElementsByTagNameNS(xNS, "sort")[0];
           }
           
           /*
            * 
           // Upon selection, sort by selected option
           // We need to use as a toggle for ascending and descending
           var selectValue  = "date";   // selection value for sort 
           var currentSelect = "date";   // selection value for sort 
           var currentDataType = "text";  // selection of datatype for text, numeric, alpha
           var currentOrder = "descending";  // Sort direction for ascending or descending
           
           I created logic for the variable setting of selectValue using Event 
           execution when the user clicks the title heading.
        
           */
          
           if (selectValue == currentSelect) {
               if (currentOrder == "ascending") currentOrder = "descending";
               else currentOrder="ascending";
           } else if (selectValue != currentSelect) currentSelect = selectValue;
           
           if (currentSelect == "amount") currentDataType = "number";
           else currentDataType = "text";
          
           //  Set sorting attributes            
           //  sortNode.setAttribute("select", select);
           sortNode.setAttribute("select", currentSelect);
           sortNode.setAttribute("data-type", currentDataType);
           sortNode.setAttribute("order", currentOrder);
           
       }       
