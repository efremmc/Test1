<?xml version="1.0" encoding="UTF-8" ?>
<!--
   New Perspectives on XML
   Tutorial 10
   Case Problem 2

   Game Scoring Selection Lists
   Author: 
   Date:   

   Filename:         scoring.xsl
   Supporting Files: 
-->

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" version="4.0" omit-xml-declaration="yes" />

<xsl:template match="/">
   <xsl:apply-templates select="game" />
</xsl:template>

<xsl:template match="game">
   <table class="scoring">
   <tr><th>Player</th>
       <td><select name="player" class="scoring">
              <xsl:apply-templates select="team" />
           </select>
       </td>
   </tr>
   <tr>
      <th>Action</th>
      <td><select name="action" class="scoring">
          <optgroup label="Shots Made">
             <option>makes 2-pt shot</option>
              <option>makes 3-pt shot</option>
          </optgroup>
          <optgroup label="Shots Missed">
             <option>misses 2-pt shot</option>
             <option>misses 3-pt shot</option>
          </optgroup>
             <optgroup label="Free Throws">
             <option>makes free throw</option>
             <option>misses free throw</option>
          </optgroup>
          <optgroup label="Rebounds">
             <option>grabs offensive rebound</option>
             <option>grabs defensive rebound</option>
          </optgroup>
          <optgroup label="Other">
             <option>assists</option>
             <option>steals ball</option>
             <option>commits turn-over</option>
             <option>commits personal foul</option>
          </optgroup>
          </select>
      </td>
   </tr>
   <tr>
      <th>Time</th>
      <td><select name="min">
             <option>19</option><option>18</option><option>17</option><option>16</option>
             <option>15</option><option>14</option><option>13</option><option>12</option>
             <option>11</option><option>10</option><option>09</option><option>08</option>
             <option>07</option><option>06</option><option>05</option><option>04</option>
             <option>03</option><option>02</option><option>01</option><option>00</option>
           </select>
           :
           <select name="sec">
             <option>59</option><option>58</option><option>57</option><option>56</option>
             <option>55</option><option>54</option><option>53</option><option>52</option>
             <option>51</option><option>50</option><option>49</option><option>48</option>
             <option>47</option><option>46</option><option>45</option><option>44</option>
             <option>43</option><option>42</option><option>41</option><option>40</option>
             <option>39</option><option>38</option><option>37</option><option>36</option>
             <option>35</option><option>34</option><option>33</option><option>32</option>
             <option>31</option><option>30</option><option>29</option><option>28</option>
             <option>27</option><option>26</option><option>25</option><option>24</option>
             <option>23</option><option>22</option><option>21</option><option>20</option>
             <option>19</option><option>18</option><option>17</option><option>16</option>
             <option>15</option><option>14</option><option>13</option><option>12</option>
             <option>11</option><option>10</option><option>09</option><option>08</option>
             <option>07</option><option>06</option><option>05</option><option>04</option>
             <option>03</option><option>02</option><option>01</option><option>00</option>
           </select>
      </td>
   </tr>
   <tr>
      <td colspan="2" align="center">
          <input type="button" value="Submit Play" />
      </td>
   </tr>
   </table>

</xsl:template>

<xsl:template match="team">
   <optgroup label="{@name}">
      <xsl:apply-templates select="player" />
   </optgroup>
</xsl:template>

<xsl:template match="player">
   <option value="{../@name}">
      <xsl:value-of select="@name" />
   </option>
</xsl:template>

</xsl:stylesheet>