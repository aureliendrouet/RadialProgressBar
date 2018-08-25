// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "AdultLink/RadialHealthBar/RadialHealthBar_UI"
{
	Properties
	{
		[PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
		_Color ("Tint", Color) = (1,1,1,1)
		[MaterialToggle] PixelSnap ("Pixel snap", Float) = 0
		[PerRendererData] _AlphaTex ("External Alpha", 2D) = "white" {}
		_Radius("Radius", Range( 0 , 1)) = 0.17
		_Arcrange("Arc range", Range( 0 , 360)) = 0
		_Fillpercentage("Fill percentage", Range( 0 , 1)) = 0.2608101
		[HDR]_Barmincolor("Bar min color", Color) = (1,0,0,0)
		[HDR]_Barmaxcolor("Bar max color", Color) = (0,1,0.08965516,0)
		[HDR]_Barsecondarymincolor("Bar secondary min color", Color) = (1,0,0,0)
		[HDR]_Barsecondarymaxcolor("Bar secondary max color", Color) = (0,1,0.08965516,0)
		[HDR]_Bordermincolor("Border min color", Color) = (1,0,0,0)
		[HDR]_Bordermaxcolor("Border max color", Color) = (0,1,0.08965516,0)
		_Mainborderradialwidth("Main border radial width", Range( 0 , 0.2)) = 0
		_Mainbordertangentwidth("Main border tangent width", Range( 0 , 1)) = 0
		_Backgroundbordertangentwidth("Background border tangent width", Range( 0 , 1)) = 0
		_Backgroundborderradialwidth("Background border radial width", Range( 0 , 0.2)) = 0
		[HDR]_Backgroundbordercolor("Background border color", Color) = (0.2132353,0.6418865,1,0)
		[HDR]_Backgroundfillcolor("Background fill color", Color) = (0.2132353,0.6418865,1,0)
		[NoScaleOffset]_Maintex("Main tex", 2D) = "white" {}
		[Toggle]_Invertmaintex("Invertmaintex", Float) = 0
		[Toggle]_Invertmaintexalpha("Invertmaintexalpha", Float) = 0
		_Maintexscrollspeed("Main tex scroll speed", Vector) = (0,0,0,0)
		_Maintextiling("Main tex tiling", Vector) = (0,0,0,0)
		_Maintexoffset("Main tex offset", Vector) = (0,0,0,0)
		[NoScaleOffset]_Secondarytex("Secondary tex", 2D) = "white" {}
		[Toggle]_Invertsecondarytex("Invertsecondarytex", Float) = 1
		[Toggle]_Invertsecondarytexalpha("Invertsecondarytexalpha", Float) = 1
		_Secondarytexscrollspeed("Secondary tex scroll speed", Vector) = (0,0,0,0)
		_Secondarytextiling("Secondary tex tiling", Vector) = (0,0,0,0)
		_Secondarytexoffset("Secondary tex offset", Vector) = (0,0,0,0)
		[NoScaleOffset]_Noisetex("Noise tex", 2D) = "white" {}
		[Toggle]_Invertnoisetex("Invertnoisetex", Float) = 0
		_Noisetexspeed("Noise tex speed", Vector) = (0,0,0,0)
		_Noisetextiling("Noise tex tiling", Vector) = (0,0,0,0)
		_Noisetexoffset("Noise tex offset", Vector) = (0,0,0,0)
		_Noiseintensity("Noise intensity", Float) = 5.01
		_Maintexrotationspeed("Main tex rotation speed", Float) = 1
		_Secondarytexrotationspeed("Secondary tex rotation speed", Float) = 1
		[KeywordEnum(Scroll,Rotate,None)] _Mainscrollrotate("Main scroll rotate", Float) = 0
		[KeywordEnum(Scroll,Rotate,None)] _Secondaryscrollrotate("Secondary scroll rotate", Float) = 0
		_Globalopacity("Global opacity", Range( 0 , 1)) = 0
		_Backgroundborderopacity("Background border opacity", Range( 0 , 1)) = 0
		_Backgroundopacity("Background opacity", Range( 0 , 1)) = 0
		_Secondarytexopacity("Secondary tex opacity", Range( 0 , 1)) = 0
		_Maintextureopacity("Main texture opacity", Range( 0 , 1)) = 0
		_Mainbarborderopacity("Main bar border opacity", Range( 0 , 1)) = 0
	}

	SubShader
	{
		Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="True" }

		Cull Off
		Lighting Off
		ZWrite Off
		Blend One OneMinusSrcAlpha
		
		
		Pass
		{
		CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile _ PIXELSNAP_ON
			#pragma multi_compile _ ETC1_EXTERNAL_ALPHA
			#include "UnityCG.cginc"
			#include "UnityShaderVariables.cginc"
			#pragma shader_feature _SECONDARYSCROLLROTATE_SCROLL _SECONDARYSCROLLROTATE_ROTATE _SECONDARYSCROLLROTATE_NONE
			#pragma shader_feature _MAINSCROLLROTATE_SCROLL _MAINSCROLLROTATE_ROTATE _MAINSCROLLROTATE_NONE


			struct appdata_t
			{
				float4 vertex   : POSITION;
				float4 color    : COLOR;
				float2 texcoord : TEXCOORD0;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
			};

			struct v2f
			{
				float4 vertex   : SV_POSITION;
				fixed4 color    : COLOR;
				float2 texcoord  : TEXCOORD0;
				UNITY_VERTEX_OUTPUT_STEREO
				
			};
			
			uniform fixed4 _Color;
			uniform float _EnableExternalAlpha;
			uniform sampler2D _MainTex;
			uniform sampler2D _AlphaTex;
			uniform float _Invertsecondarytex;
			uniform sampler2D _Secondarytex;
			uniform float2 _Secondarytexscrollspeed;
			uniform float2 _Secondarytextiling;
			uniform float2 _Secondarytexoffset;
			uniform float _Secondarytexrotationspeed;
			uniform float _Invertsecondarytexalpha;
			uniform float _Invertnoisetex;
			uniform sampler2D _Noisetex;
			uniform float2 _Noisetexspeed;
			uniform float2 _Noisetextiling;
			uniform float2 _Noisetexoffset;
			uniform float _Noiseintensity;
			uniform float _Mainborderradialwidth;
			uniform float _Backgroundborderradialwidth;
			uniform float _Mainbordertangentwidth;
			uniform float _Fillpercentage;
			uniform float _Arcrange;
			uniform float _Backgroundbordertangentwidth;
			uniform float _Radius;
			uniform float4 _Barsecondarymincolor;
			uniform float4 _Barsecondarymaxcolor;
			uniform float _Secondarytexopacity;
			uniform float4 _Bordermincolor;
			uniform float4 _Bordermaxcolor;
			uniform float _Mainbarborderopacity;
			uniform float _Invertmaintex;
			uniform sampler2D _Maintex;
			uniform float2 _Maintexscrollspeed;
			uniform float2 _Maintextiling;
			uniform float2 _Maintexoffset;
			uniform float _Maintexrotationspeed;
			uniform float _Invertmaintexalpha;
			uniform float4 _Barmincolor;
			uniform float4 _Barmaxcolor;
			uniform float _Maintextureopacity;
			uniform float4 _Backgroundbordercolor;
			uniform float _Backgroundborderopacity;
			uniform float4 _Backgroundfillcolor;
			uniform float _Backgroundopacity;
			uniform float _Globalopacity;
			
			v2f vert( appdata_t IN  )
			{
				v2f OUT;
				UNITY_SETUP_INSTANCE_ID(IN);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(OUT);
				
				
				IN.vertex.xyz +=  float3(0,0,0) ; 
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.texcoord = IN.texcoord;
				OUT.color = IN.color * _Color;
				#ifdef PIXELSNAP_ON
				OUT.vertex = UnityPixelSnap (OUT.vertex);
				#endif

				return OUT;
			}

			fixed4 SampleSpriteTexture (float2 uv)
			{
				fixed4 color = tex2D (_MainTex, uv);

#if ETC1_EXTERNAL_ALPHA
				// get the color from an external texture (usecase: Alpha support for ETC1 on android)
				fixed4 alpha = tex2D (_AlphaTex, uv);
				color.a = lerp (color.a, alpha.r, _EnableExternalAlpha);
#endif //ETC1_EXTERNAL_ALPHA

				return color;
			}
			
			fixed4 frag(v2f IN  ) : SV_Target
			{
				float2 temp_output_332_0 = (float2( 0,0 ) + (_Secondarytexoffset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
				float2 uv341 = IN.texcoord.xy * _Secondarytextiling + temp_output_332_0;
				float2 panner343 = ( _Time.y * (float2( 0,0 ) + (_Secondarytexscrollspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv341);
				float2 uv339 = IN.texcoord.xy * _Secondarytextiling + temp_output_332_0;
				float mulTime340 = _Time.y * _Secondarytexrotationspeed;
				float cos344 = cos( mulTime340 );
				float sin344 = sin( mulTime340 );
				float2 rotator344 = mul( uv339 - ( _Secondarytextiling * float2( 0.5,0.5 ) ) , float2x2( cos344 , -sin344 , sin344 , cos344 )) + ( _Secondarytextiling * float2( 0.5,0.5 ) );
				#if defined(_SECONDARYSCROLLROTATE_SCROLL)
				float2 staticSwitch345 = panner343;
				#elif defined(_SECONDARYSCROLLROTATE_ROTATE)
				float2 staticSwitch345 = rotator344;
				#elif defined(_SECONDARYSCROLLROTATE_NONE)
				float2 staticSwitch345 = uv341;
				#else
				float2 staticSwitch345 = panner343;
				#endif
				float4 tex2DNode89 = tex2D( _Secondarytex, staticSwitch345 );
				float4 appendResult326 = (float4(( 1.0 - tex2DNode89.r ) , ( 1.0 - tex2DNode89.g ) , ( 1.0 - tex2DNode89.b ) , lerp(tex2DNode89.a,( 1.0 - tex2DNode89.a ),_Invertsecondarytexalpha)));
				float4 Secondarytexture126 = lerp(tex2DNode89,appendResult326,_Invertsecondarytex);
				float2 uv94 = IN.texcoord.xy * _Noisetextiling + _Noisetexoffset;
				float2 panner96 = ( _Time.y * (float2( 0,0 ) + (_Noisetexspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv94);
				float Noiseintensity167 = _Noiseintensity;
				float4 temp_output_98_0 = ( tex2D( _Noisetex, panner96 ) * Noiseintensity167 );
				float4 Noisetexture127 = lerp(temp_output_98_0,( 1.0 - temp_output_98_0 ),_Invertnoisetex);
				float2 uv1 = IN.texcoord.xy * float2( 1,1 ) + float2( 0,0 );
				float MainbarBorderwidth138 = _Mainborderradialwidth;
				float BackgroundBorderWidth183 = _Backgroundborderradialwidth;
				float2 temp_output_74_0 = ( float2( 1,1 ) + MainbarBorderwidth138 + BackgroundBorderWidth183 );
				float2 temp_output_11_0 = (-temp_output_74_0 + (uv1 - float2( 0,0 )) * (temp_output_74_0 - -temp_output_74_0) / (float2( 1,1 ) - float2( 0,0 )));
				float2 break28 = (temp_output_11_0).xy;
				float temp_output_29_0 = (0.0 + (atan2( break28.y , break28.x ) - -UNITY_PI) * (1.0 - 0.0) / (UNITY_PI - -UNITY_PI));
				float Borderwidth2157 = (0.0 + (_Mainbordertangentwidth - 0.0) * (0.05 - 0.0) / (1.0 - 0.0));
				float Fillpercentage140 = _Fillpercentage;
				float ArcRange205 = (0.0 + (_Arcrange - 0.0) * (1.0 - 0.0) / (360.0 - 0.0));
				float BorderWidth3252 = (0.0 + (_Backgroundbordertangentwidth - 0.0) * (0.05 - 0.0) / (1.0 - 0.0));
				float MainbarFillPercentage145 = ceil( ( temp_output_29_0 - ( Borderwidth2157 + (1.0 + (Fillpercentage140 - 0.0) * ((1.0 + (ArcRange205 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) - 1.0) / (1.0 - 0.0)) + BorderWidth3252 ) ) );
				float BarRadius133 = _Radius;
				float Length135 = length( temp_output_11_0 );
				float MainbarFill150 = ( MainbarFillPercentage145 * floor( ( BarRadius133 + Length135 ) ) * ( 1.0 - floor( Length135 ) ) );
				float4 lerpResult236 = lerp( _Barsecondarymincolor , _Barsecondarymaxcolor , Fillpercentage140);
				float4 BarSecondaryColor237 = lerpResult236;
				float4 break383 = ( Secondarytexture126 * Noisetexture127 * MainbarFill150 * BarSecondaryColor237 );
				float4 appendResult385 = (float4(break383.x , break383.y , break383.z , ( break383.w * _Secondarytexopacity )));
				float4 lerpResult73 = lerp( _Bordermincolor , _Bordermaxcolor , Fillpercentage140);
				float4 Bordercolor121 = lerpResult73;
				float MainbarBorderPercentage146 = ceil( ( temp_output_29_0 - (1.0 + (( ( Fillpercentage140 * ArcRange205 ) - BorderWidth3252 ) - 0.0) * (0.0 - 1.0) / (1.0 - 0.0)) ) );
				float temp_output_47_0 = floor( ( BarRadius133 + MainbarBorderwidth138 + Length135 ) );
				float temp_output_50_0 = ( 1.0 - floor( ( Length135 + -MainbarBorderwidth138 ) ) );
				float Biggercircle151 = ( MainbarBorderPercentage146 * temp_output_47_0 * temp_output_50_0 );
				float MainbarBorder161 = ( Biggercircle151 - MainbarFill150 );
				float4 break386 = ( Bordercolor121 * MainbarBorder161 );
				float4 appendResult389 = (float4(break386.r , break386.g , break386.b , ( break386.a * _Mainbarborderopacity )));
				float2 temp_output_357_0 = (float2( 0,0 ) + (_Maintexoffset - float2( 0,0 )) * (float2( 1,1 ) - float2( 0,0 )) / (float2( 360,360 ) - float2( 0,0 )));
				float2 uv349 = IN.texcoord.xy * _Maintextiling + temp_output_357_0;
				float2 panner352 = ( _Time.y * (float2( 0,0 ) + (_Maintexscrollspeed - float2( 0,0 )) * (float2( 0.01,0.01 ) - float2( 0,0 )) / (float2( 1,1 ) - float2( 0,0 ))) + uv349);
				float2 uv348 = IN.texcoord.xy * _Maintextiling + temp_output_357_0;
				float mulTime347 = _Time.y * _Maintexrotationspeed;
				float cos351 = cos( mulTime347 );
				float sin351 = sin( mulTime347 );
				float2 rotator351 = mul( uv348 - ( _Maintextiling * float2( 0.5,0.5 ) ) , float2x2( cos351 , -sin351 , sin351 , cos351 )) + ( _Maintextiling * float2( 0.5,0.5 ) );
				#if defined(_MAINSCROLLROTATE_SCROLL)
				float2 staticSwitch353 = panner352;
				#elif defined(_MAINSCROLLROTATE_ROTATE)
				float2 staticSwitch353 = rotator351;
				#elif defined(_MAINSCROLLROTATE_NONE)
				float2 staticSwitch353 = uv349;
				#else
				float2 staticSwitch353 = panner352;
				#endif
				float4 tex2DNode38 = tex2D( _Maintex, staticSwitch353 );
				float4 appendResult313 = (float4(( 1.0 - tex2DNode38.r ) , ( 1.0 - tex2DNode38.g ) , ( 1.0 - tex2DNode38.b ) , lerp(tex2DNode38.a,( 1.0 - tex2DNode38.a ),_Invertmaintexalpha)));
				float4 Maintexture131 = lerp(tex2DNode38,appendResult313,_Invertmaintex);
				float4 lerpResult6 = lerp( _Barmincolor , _Barmaxcolor , Fillpercentage140);
				float4 BarColor123 = lerpResult6;
				float4 break390 = ( MainbarFill150 * Maintexture131 * BarColor123 );
				float4 appendResult393 = (float4(break390.x , break390.y , break390.z , ( break390.w * _Maintextureopacity )));
				float temp_output_258_0 = (1.0 + (ArcRange205 - 0.0) * (0.0 - 1.0) / (1.0 - 0.0));
				float BackgroundBorderPercentage257 = ceil( ( temp_output_29_0 - temp_output_258_0 ) );
				float temp_output_186_0 = ( MainbarBorderwidth138 + BackgroundBorderWidth183 );
				float Background181 = ( BackgroundBorderPercentage257 * floor( ( BarRadius133 + temp_output_186_0 + Length135 ) ) * ( 1.0 - floor( ( Length135 + -temp_output_186_0 ) ) ) );
				float BackgroundFillPercentage211 = ceil( ( temp_output_29_0 - ( BorderWidth3252 + temp_output_258_0 ) ) );
				float BackgroundFillFull262 = ( BackgroundFillPercentage211 * floor( ( BarRadius133 + MainbarBorderwidth138 + Length135 ) ) * ( 1.0 - floor( ( Length135 + -MainbarBorderwidth138 ) ) ) );
				float clampResult217 = clamp( ( Background181 - BackgroundFillFull262 ) , 0.0 , 1.0 );
				float BackgroundBorder191 = clampResult217;
				float4 BGColor194 = _Backgroundbordercolor;
				float4 break394 = ( BackgroundBorder191 * BGColor194 );
				float4 appendResult397 = (float4(break394.r , break394.g , break394.b , ( break394.a * _Backgroundborderopacity )));
				float BackgroundFillEmpty223 = ( BackgroundFillFull262 - Biggercircle151 );
				float4 BackgroundFillColor229 = _Backgroundfillcolor;
				float4 break398 = ( BackgroundFillEmpty223 * BackgroundFillColor229 );
				float4 appendResult401 = (float4(break398.r , break398.g , break398.b , ( break398.a * _Backgroundopacity )));
				float4 break372 = ( appendResult385 + appendResult389 + appendResult393 + appendResult397 + appendResult401 );
				float Opacity377 = _Globalopacity;
				float4 appendResult375 = (float4(break372.x , break372.y , break372.z , ( break372.w * Opacity377 )));
				
				fixed4 c = appendResult375;
				c.rgb *= c.a;
				return c;
			}
		ENDCG
		}
	}
	CustomEditor "RadialHealthBarEditor_UI"
	
	
}
/*ASEBEGIN
Version=15500
559;100;983;448;-303.8613;110.1771;2.538953;True;False
Node;AmplifyShaderEditor.CommentaryNode;166;4110.384,-318.449;Float;False;830.2405;1797.381;Parameters;25;157;252;296;295;229;194;230;193;167;97;133;15;140;70;205;251;10;204;203;138;183;48;182;374;377;Parameters;0.6764706,1,0.7590263,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;102;-4029.811,183.4529;Float;False;601.5515;366.3412;Scaling to make the bar fit;5;104;74;190;75;159;Scaling;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;48;4159.64,-241.3051;Float;False;Property;_Mainborderradialwidth;Main border radial width;9;0;Create;True;0;0;False;0;0;0.054;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;182;4172.921,619.031;Float;False;Property;_Backgroundborderradialwidth;Background border radial width;12;0;Create;True;0;0;False;0;0;0.039;0;0.2;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;190;-4003.501,457.4121;Float;False;183;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;138;4436.015,-241.4851;Float;False;MainbarBorderwidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;159;-3999.633,374.289;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;75;-3980.435,240.0866;Float;False;Constant;_Vector0;Vector 0;11;0;Create;True;0;0;False;0;1,1;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RegisterLocalVarNode;183;4466.886,620.6659;Float;False;BackgroundBorderWidth;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;74;-3745.977,297.3924;Float;False;3;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-3709.973,-343.8436;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;104;-3619.288,233.2726;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;11;-3202.178,194.2136;Float;True;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;-1,-1;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;114;-2465.016,-259.4199;Float;False;2609.482;1113.476;Generate percentage masks;38;158;141;208;207;142;213;259;257;258;256;255;218;145;34;33;146;67;66;65;214;29;289;36;23;105;30;28;26;209;210;211;290;273;265;292;304;303;302;Generate percentage masks;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;203;4160.519,1236.924;Float;False;Property;_Arcrange;Arc range;1;0;Create;True;0;0;False;0;0;360;0;360;0;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;26;-2348.671,323.6691;Float;True;True;True;False;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TFHCRemapNode;204;4448.803,1241.844;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;360;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;169;-2666.874,2792.588;Float;False;1794.242;668.8176;Even bigger circle for BG;14;261;181;180;177;179;175;176;174;173;172;171;186;170;184;Even bigger circle for BG;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;108;-3125.88,-3079.963;Float;False;3222.244;828.958;Main texture;24;346;347;349;45;355;116;115;358;357;351;353;352;350;348;131;243;313;244;315;314;318;317;38;360;Main texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;109;-3118.685,-2074.214;Float;False;3189.201;823.0469;Secondary texture;24;334;340;120;336;332;119;337;85;341;345;343;344;342;339;325;327;126;245;326;324;312;323;89;361;Secondary texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.BreakToComponentsNode;28;-2098.829,324.9987;Float;True;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;251;4149.741,271.6759;Float;False;Property;_Backgroundbordertangentwidth;Background border tangent width;11;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PiNode;30;-1946.094,647.7456;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;4155.891,-45.327;Float;False;Property;_Fillpercentage;Fill percentage;2;0;Create;True;0;0;False;0;0.2608101;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;205;4632.683,1231.785;Float;False;ArcRange;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;293;-2541.062,3551.154;Float;False;1585.7;689.2803;Background Fill;12;262;260;212;283;284;282;281;279;280;278;277;274;Background Fill;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;170;-2619.162,3055.632;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;116;-3068.194,-2718.396;Float;False;Property;_Maintexoffset;Main tex offset;20;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;120;-3045.777,-1701.794;Float;False;Property;_Secondarytexoffset;Secondary tex offset;26;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.RangedFloatNode;70;4153.716,61.35442;Float;False;Property;_Mainbordertangentwidth;Main border tangent width;10;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ATan2OpNode;23;-1813.874,324.8884;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;-1489.249,599.0247;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;213;-1467.342,680.778;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;259;-1138.713,135.584;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;296;4469.235,289.0914;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;-2623.425,3157.401;Float;False;183;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;140;4444.837,-46.52695;Float;False;Fillpercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;-2007.468,120.3304;Float;False;205;0;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;105;-1739.124,685.3541;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;208;-1791.658,127.2541;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;336;-2769.522,-1839.531;Float;False;Constant;_Anchorbase2;Anchor base2;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TFHCRemapNode;357;-2833.803,-2715.028;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;119;-2814.504,-1985.797;Float;False;Property;_Secondarytextiling;Secondary tex tiling;25;0;Create;True;0;0;False;0;0,0;0.2,0.2;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;358;-2842.563,-2857.36;Float;False;Constant;_Anchorbase;Anchor base;47;0;Create;True;0;0;False;0;0.5,0.5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.GetLocalVarNode;141;-1785.429,43.17583;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.LengthOpNode;12;-2904.638,446.3433;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;45;-2666.492,-2492.336;Float;False;Property;_Maintexscrollspeed;Main tex scroll speed;18;0;Create;True;0;0;False;0;0,0;1,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.Vector2Node;115;-2837.409,-3002.03;Float;False;Property;_Maintextiling;Main tex tiling;19;0;Create;True;0;0;False;0;0,0;0.5,0.5;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.TFHCRemapNode;29;-1543.135,359.6689;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;332;-2760.761,-1697.199;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;360,360;False;3;FLOAT2;0,0;False;4;FLOAT2;1,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;265;-963.3506,-101.0643;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;303;-1483.998,768.8998;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;186;-2328.033,3118.946;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;252;4646.44,290.4834;Float;False;BorderWidth3;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;214;-1227.301,609.2108;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;346;-2440.893,-2756.741;Float;False;Property;_Maintexrotationspeed;Main tex rotation speed;33;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;106;-2529.871,1255.103;Float;False;1730.515;589.2817;Bigger circle for border;14;216;215;151;52;149;47;50;46;49;132;51;137;103;139;Bigger circle for border;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;274;-2495.224,3802.979;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;295;4447.873,73.40568;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;334;-2403.7,-1755.403;Float;False;Property;_Secondarytexrotationspeed;Secondary tex rotation speed;34;0;Create;True;0;0;False;0;1;-0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;258;-958.3196,142.1667;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;85;-2676.394,-1507.051;Float;False;Property;_Secondarytexscrollspeed;Secondary tex scroll speed;24;0;Create;True;0;0;False;0;0,0;-0.5,-0.15;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;350;-2360.16,-2876.297;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-2509.071,1398.734;Float;False;138;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;36;-1570.776,127.432;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;157;4624.759,72.02412;Float;False;Borderwidth2;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;278;-2196.334,3904.757;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;304;-1150.411,467.7894;Float;False;252;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;348;-2360.53,-2993.059;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;355;-2384.434,-2321.364;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;340;-2110.217,-1756.425;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;158;-1549.128,47.98973;Float;False;157;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;341;-2351.371,-1649.251;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;277;-2194.759,3981.393;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;171;-2138.211,3144.654;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;4156.279,-144.9161;Float;False;Property;_Radius;Radius;0;0;Create;True;0;0;False;0;0.17;0.381;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;342;-2307.854,-1858.468;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;135;-2728.105,437.7355;Float;True;Length;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;349;-2405.033,-2640.631;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;290;-1280.2,-159.6177;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;172;-2136.635,3221.29;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;347;-2177.862,-2761.827;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;302;-1070.292,752.7352;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;273;-748.0826,-92.72653;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;339;-2308.224,-1975.229;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;289;-1163.404,84.09908;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;110;-2015.344,-1105.234;Float;False;2086.113;493.8669;Noise texture;13;127;247;246;98;168;92;96;93;94;95;117;118;362;Noise texture;1,1,1,1;0;0
Node;AmplifyShaderEditor.TFHCRemapNode;361;-2316.81,-1524.846;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;337;-2316.419,-1347.921;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;360;-2382.627,-2510.419;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;352;-2004.168,-2564.484;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;-2227.285,1463.243;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;65;-842.91,637.4735;Float;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;1;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;209;-605.8688,-138.4702;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;107;-2520.544,1931.904;Float;False;1425.286;534.8368;Mainbar Fill;9;150;20;147;17;19;16;14;134;136;Mainbar Fill;1,1,1,1;0;0
Node;AmplifyShaderEditor.RotatorNode;351;-1970.932,-2880.206;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.NegateNode;103;-2203.931,1583.437;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;292;-1261.835,515.8734;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;174;-2405.979,2954.64;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;173;-1952.988,3198.153;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;4429.807,-143.6881;Float;False;BarRadius;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;118;-1984.956,-916.6685;Float;False;Property;_Noisetexoffset;Noise tex offset;31;0;Create;True;0;0;False;0;0,0;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleSubtractOpNode;255;-605.4991,94.28665;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;280;-2464.102,3714.743;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;343;-1951.861,-1546.655;Float;True;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;117;-1980.337,-1037.508;Float;False;Property;_Noisetextiling;Noise tex tiling;30;0;Create;True;0;0;False;0;0,0;1,1;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;218;-795.887,438.9902;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;344;-1918.626,-1862.376;Float;True;3;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;2;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Vector2Node;93;-1957.809,-763.3;Float;False;Property;_Noisetexspeed;Noise tex speed;29;0;Create;True;0;0;False;0;0,0;-0.5,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.SimpleAddOpNode;279;-2011.112,3958.256;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;345;-1650.833,-1687.763;Float;False;Property;_Secondaryscrollrotate;Secondary scroll rotate;36;0;Create;True;0;0;False;0;0;0;1;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;134;-2470.613,1987.59;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;281;-1964.888,3719.396;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-2473.275,1316.786;Float;False;133;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;66;-606.8147,573.4583;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;176;-1906.764,2959.293;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;282;-1890.126,3960.008;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;94;-1709.039,-1001.192;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;33;-603.7076,337.7349;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;353;-1678.49,-2697.09;Float;False;Property;_Mainscrollrotate;Main scroll rotate;35;0;Create;True;0;0;False;0;0;0;0;True;;KeywordEnum;3;Scroll;Rotate;None;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleTimeNode;95;-1671.085,-687.0905;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;210;-397.3276,-138.7356;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;-2473.071,2119.291;Float;False;135;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;256;-396.9577,94.02127;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;175;-1832.002,3199.905;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;362;-1675.617,-863.2327;Float;False;5;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;2;FLOAT2;1,1;False;3;FLOAT2;0,0;False;4;FLOAT2;0.01,0.01;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;51;-2020.285,1560.299;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;257;-259.8394,88.93338;Float;True;BackgroundBorderPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;16;-2213.207,2217.397;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;89;-1346.07,-1709.314;Float;True;Property;_Secondarytex;Secondary tex;21;1;[NoScaleOffset];Create;True;0;0;False;0;None;6a35c1fbda267f042864c469d8d0136f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;283;-1697.459,3972.193;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;179;-1639.334,3212.09;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;97;4169.984,499.3177;Float;False;Property;_Noiseintensity;Noise intensity;32;0;Create;True;0;0;False;0;5.01;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;284;-1713.612,3718.816;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;96;-1355.665,-902.4893;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;1,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;211;-256.1796,-143.8235;Float;True;BackgroundFillPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;261;-1725.569,2854.55;Float;False;257;0;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;67;-393.7538,573.2755;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;-1336.324,-2857.509;Float;True;Property;_Maintex;Main tex;15;1;[NoScaleOffset];Create;True;0;0;False;0;None;6a35c1fbda267f042864c469d8d0136f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FloorOpNode;177;-1655.487,2958.713;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;49;-1899.3,1562.051;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;46;-1974.062,1321.438;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;34;-394.7443,337.3792;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;212;-1791.268,3616.776;Float;False;211;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-2236.631,1990.623;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;50;-1706.632,1574.236;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;146;-261.1469,568.8488;Float;True;MainbarBorderPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;17;-1986.393,2218.228;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;260;-1384.749,3777.411;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;47;-1722.785,1320.858;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;317;-1054.969,-2574.751;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;147;-1735.686,1991.772;Float;False;145;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;-261.643,332.954;Float;True;MainbarFillPercentage;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;168;-1086.591,-750.968;Float;False;167;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;149;-1518.75,1296.566;Float;False;146;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;327;-1046.435,-1405.693;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;19;-1987.305,1990.043;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;180;-1280.736,3012.119;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;167;4365.541,499.7834;Float;False;Noiseintensity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;92;-1159.307,-947.4838;Float;True;Property;_Noisetex;Noise tex;27;1;[NoScaleOffset];Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;262;-1230.803,3754.746;Float;True;BackgroundFillFull;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;315;-859.6165,-2689.929;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;238;5097.238,749.7537;Float;False;948.353;475.3962;Bar secondary color;5;233;237;235;234;236;Bar secondary color;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;314;-867.4165,-2755.73;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;192;-428.2353,3226.427;Float;False;618.8071;323.468;BG Border ;3;191;217;189;BG Border ;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;312;-929.5167,-1700.239;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;111;5083.419,-299.1437;Float;False;954.1964;416.8591;Border color;5;121;73;71;144;72;Border color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;52;-1241.511,1401.763;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-1507.063,2178.498;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;323;-926.2817,-1554.802;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;-842.3475,-945.6967;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ToggleSwitchNode;318;-842.9785,-2591.534;Float;False;Property;_Invertmaintexalpha;Invertmaintexalpha;17;0;Create;True;0;0;False;0;0;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;325;-861.9699,-1449.843;Float;False;Property;_Invertsecondarytexalpha;Invertsecondarytexalpha;23;0;Create;True;0;0;False;0;1;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;112;5090.387,225.4276;Float;False;920.9249;437.3615;Bar color;5;7;8;143;6;123;Bar color;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;324;-929.6877,-1629.712;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;286;-434.8913,3616.03;Float;False;643.9;272.5649;BG Fill Empty;3;223;285;240;BG Fill Empty;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;244;-868.0186,-2823.367;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;181;-1117.1,2994.273;Float;True;Background;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;246;-623.6175,-876.7789;Float;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;326;-658.1904,-1770.017;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;233;5118.678,805.0606;Float;False;Property;_Barsecondarymincolor;Bar secondary min color;5;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0.3651115,0.5514706,0.06893375,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;313;-542.85,-2913.793;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;234;5386.121,1058.323;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;5411.979,24.92087;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;5377.892,552.5139;Float;False;140;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;240;-414.3459,3805.728;Float;False;151;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;8;5141.837,286.4486;Float;False;Property;_Barmincolor;Bar min color;3;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0.3992364,0.8235294,0.05449823,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;72;5141.84,-64.39629;Float;False;Property;_Bordermaxcolor;Border max color;8;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,0;0.01113755,0.7573529,0.2324283,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;71;5149.703,-241.8233;Float;False;Property;_Bordermincolor;Border min color;7;1;[HDR];Create;True;0;0;False;0;1,0,0,0;0.2661018,0.6176471,0.06358126,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;151;-1077.876,1395.799;Float;True;Biggercircle;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;189;-417.7115,3279.102;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;7;5138.596,458.229;Float;False;Property;_Barmaxcolor;Bar max color;4;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,0;0.02897927,0.985294,0.3125736,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;150;-1348.128,2173.948;Float;True;MainbarFill;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;235;5117.557,974.7197;Float;False;Property;_Barsecondarymaxcolor;Bar secondary max color;6;1;[HDR];Create;True;0;0;False;0;0,1,0.08965516,0;0.04876721,0.6029412,0.3728181,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;163;-603.3226,1716.62;Float;False;736.1537;360.9658;Main bar Border;2;161;160;Main bar Border;1,1,1,1;0;0
Node;AmplifyShaderEditor.ClampOpNode;217;-203.8913,3286.892;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;236;5618.143,914.2628;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;193;4170.672,727.4504;Float;False;Property;_Backgroundbordercolor;Background border color;13;1;[HDR];Create;True;0;0;False;0;0.2132353,0.6418865,1,0;0,0.4606999,0.8455882,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.CommentaryNode;165;1322.628,-329.5287;Float;False;2546.855;1710.77;Final composition;44;373;371;375;372;376;59;401;400;399;398;221;231;228;397;396;395;394;195;197;196;393;392;391;390;156;39;130;124;389;388;387;386;57;162;122;385;384;383;382;91;241;129;154;128;Final composition;0.6470588,0.8539554,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;73;5643.618,-144.2223;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;6;5601.794,408.4546;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;160;-568.2471,1782.769;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;245;-549.8199,-1918.911;Float;False;Property;_Invertsecondarytex;Invertsecondarytex;22;0;Create;True;0;0;False;0;1;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;285;-194.1326,3662.843;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ToggleSwitchNode;243;-388.4345,-3019.269;Float;False;Property;_Invertmaintex;Invertmaintex;16;0;Create;True;0;0;False;0;0;2;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ToggleSwitchNode;247;-445.5462,-953.8237;Float;False;Property;_Invertnoisetex;Invertnoisetex;28;0;Create;True;0;0;False;0;0;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;230;4169.206,939.5326;Float;False;Property;_Backgroundfillcolor;Background fill color;14;1;[HDR];Create;True;0;0;False;0;0.2132353,0.6418865,1,0;0,0.2084096,0.3897058,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;129;1400.486,-265.7046;Float;False;126;0;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;241;1376.175,-25.33563;Float;False;237;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;1406.485,848.1989;Float;False;194;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;228;1386.801,1062.747;Float;False;223;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;128;1401.821,-183.2427;Float;False;127;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;154;1401.373,-102.1017;Float;False;150;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;122;1395.488,113.942;Float;False;121;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;162;1395.319,205.747;Float;False;161;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;124;1400.943,542.5403;Float;False;123;0;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;196;1409.973,760.8313;Float;False;191;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;156;1403.586,370.8387;Float;False;150;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;130;1402.119,453.3549;Float;False;131;0;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;231;1386.649,1146.475;Float;False;229;0;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;126;-290.8534,-1920.412;Float;True;Secondarytexture;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;191;-53.09107,3282.352;Float;True;BackgroundBorder;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;237;5774.193,909.0757;Float;True;BarSecondaryColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;123;5757.844,403.2677;Float;True;BarColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;194;4428.448,731.2079;Float;False;BGColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;131;-141.882,-3019.23;Float;True;Maintexture;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;121;5798.399,-143.9892;Float;True;Bordercolor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;127;-206.9963,-956.8516;Float;True;Noisetexture;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;161;-221.9629,1766.11;Float;True;MainbarBorder;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;223;-52.65546,3657.94;Float;True;BackgroundFillEmpty;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;229;4420.258,937.9106;Float;False;BackgroundFillColor;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;221;1726.593,1063.537;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;195;1737.255,726.665;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;39;1732.843,423.8007;Float;True;3;3;0;FLOAT;0;False;1;FLOAT4;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;1724.877,-166.7096;Float;True;4;4;0;FLOAT4;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;3;COLOR;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;1732.332,119.023;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;391;1941.019,530.674;Float;False;Property;_Maintextureopacity;Main texture opacity;41;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;382;1917.285,-111.7543;Float;False;Property;_Secondarytexopacity;Secondary tex opacity;40;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;398;2003.809,1063.167;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;399;1985.369,1215.165;Float;False;Property;_Backgroundopacity;Background opacity;39;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;394;1987.766,729.6344;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;395;1969.326,881.6322;Float;False;Property;_Backgroundborderopacity;Background border opacity;38;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;390;1959.458,378.6761;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.BreakToComponentsNode;386;1973.694,97.81126;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.RangedFloatNode;387;1946.853,252.6094;Float;False;Property;_Mainbarborderopacity;Main bar border opacity;42;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;383;1935.725,-263.752;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;388;2241.812,205.8089;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;396;2255.884,837.6321;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;400;2271.927,1171.165;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;392;2227.576,486.6739;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;384;2203.843,-155.7543;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;393;2386.135,378.6761;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;397;2414.442,729.6344;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;389;2400.369,97.81126;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;401;2430.485,1063.167;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;385;2362.401,-263.752;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;59;2762.453,373.7587;Float;True;5;5;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;374;4160.498,1128.016;Float;False;Property;_Globalopacity;Global opacity;37;0;Create;True;0;0;False;0;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;372;3003.096,522.9155;Float;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.GetLocalVarNode;376;3031.919,698.629;Float;False;377;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;377;4443.461,1121.818;Float;False;Opacity;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;373;3261.377,627.9815;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;375;3436.24,316.9993;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;215;-1264.508,1618.066;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;216;-1095.355,1631.101;Float;True;BiggerCircleFull;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;371;3591.389,314.1487;Float;False;True;2;Float;RadialHealthBarEditor_UI;0;5;AdultLink/RadialHealthBar/RadialHealthBar_UI;0f8ba0101102bb14ebf021ddadce9b49;0;0;SubShader 0 Pass 0;2;True;3;1;False;-1;10;False;-1;0;1;False;-1;0;False;-1;False;True;2;False;-1;False;False;True;2;False;-1;False;False;True;5;Queue=Transparent;IgnoreProjector=True;RenderType=Transparent;PreviewType=Plane;CanUseSpriteAtlas=True;False;0;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;138;0;48;0
WireConnection;183;0;182;0
WireConnection;74;0;75;0
WireConnection;74;1;159;0
WireConnection;74;2;190;0
WireConnection;104;0;74;0
WireConnection;11;0;1;0
WireConnection;11;3;104;0
WireConnection;11;4;74;0
WireConnection;26;0;11;0
WireConnection;204;0;203;0
WireConnection;28;0;26;0
WireConnection;205;0;204;0
WireConnection;23;0;28;1
WireConnection;23;1;28;0
WireConnection;296;0;251;0
WireConnection;140;0;10;0
WireConnection;105;0;30;0
WireConnection;208;0;207;0
WireConnection;357;0;116;0
WireConnection;12;0;11;0
WireConnection;29;0;23;0
WireConnection;29;1;105;0
WireConnection;29;2;30;0
WireConnection;332;0;120;0
WireConnection;186;0;170;0
WireConnection;186;1;184;0
WireConnection;252;0;296;0
WireConnection;214;0;142;0
WireConnection;214;1;213;0
WireConnection;295;0;70;0
WireConnection;258;0;259;0
WireConnection;350;0;115;0
WireConnection;350;1;358;0
WireConnection;36;0;141;0
WireConnection;36;4;208;0
WireConnection;157;0;295;0
WireConnection;348;0;115;0
WireConnection;348;1;357;0
WireConnection;340;0;334;0
WireConnection;341;0;119;0
WireConnection;341;1;332;0
WireConnection;277;0;274;0
WireConnection;342;0;119;0
WireConnection;342;1;336;0
WireConnection;135;0;12;0
WireConnection;349;0;115;0
WireConnection;349;1;357;0
WireConnection;290;0;29;0
WireConnection;172;0;186;0
WireConnection;347;0;346;0
WireConnection;302;0;214;0
WireConnection;302;1;303;0
WireConnection;273;0;265;0
WireConnection;273;1;258;0
WireConnection;339;0;119;0
WireConnection;339;1;332;0
WireConnection;289;0;29;0
WireConnection;361;0;85;0
WireConnection;360;0;45;0
WireConnection;352;0;349;0
WireConnection;352;2;360;0
WireConnection;352;1;355;0
WireConnection;65;0;302;0
WireConnection;209;0;290;0
WireConnection;209;1;273;0
WireConnection;351;0;348;0
WireConnection;351;1;350;0
WireConnection;351;2;347;0
WireConnection;103;0;139;0
WireConnection;292;0;29;0
WireConnection;173;0;171;0
WireConnection;173;1;172;0
WireConnection;133;0;15;0
WireConnection;255;0;289;0
WireConnection;255;1;258;0
WireConnection;343;0;341;0
WireConnection;343;2;361;0
WireConnection;343;1;337;0
WireConnection;218;0;158;0
WireConnection;218;1;36;0
WireConnection;218;2;304;0
WireConnection;344;0;339;0
WireConnection;344;1;342;0
WireConnection;344;2;340;0
WireConnection;279;0;278;0
WireConnection;279;1;277;0
WireConnection;345;1;343;0
WireConnection;345;0;344;0
WireConnection;345;2;341;0
WireConnection;281;0;280;0
WireConnection;281;1;274;0
WireConnection;281;2;278;0
WireConnection;66;0;292;0
WireConnection;66;1;65;0
WireConnection;176;0;174;0
WireConnection;176;1;186;0
WireConnection;176;2;171;0
WireConnection;282;0;279;0
WireConnection;94;0;117;0
WireConnection;94;1;118;0
WireConnection;33;0;29;0
WireConnection;33;1;218;0
WireConnection;353;1;352;0
WireConnection;353;0;351;0
WireConnection;353;2;349;0
WireConnection;210;0;209;0
WireConnection;256;0;255;0
WireConnection;175;0;173;0
WireConnection;362;0;93;0
WireConnection;51;0;137;0
WireConnection;51;1;103;0
WireConnection;257;0;256;0
WireConnection;16;0;136;0
WireConnection;89;1;345;0
WireConnection;283;0;282;0
WireConnection;179;0;175;0
WireConnection;284;0;281;0
WireConnection;96;0;94;0
WireConnection;96;2;362;0
WireConnection;96;1;95;0
WireConnection;211;0;210;0
WireConnection;67;0;66;0
WireConnection;38;1;353;0
WireConnection;177;0;176;0
WireConnection;49;0;51;0
WireConnection;46;0;132;0
WireConnection;46;1;139;0
WireConnection;46;2;137;0
WireConnection;34;0;33;0
WireConnection;14;0;134;0
WireConnection;14;1;136;0
WireConnection;50;0;49;0
WireConnection;146;0;67;0
WireConnection;17;0;16;0
WireConnection;260;0;212;0
WireConnection;260;1;284;0
WireConnection;260;2;283;0
WireConnection;47;0;46;0
WireConnection;317;0;38;4
WireConnection;145;0;34;0
WireConnection;327;0;89;4
WireConnection;19;0;14;0
WireConnection;180;0;261;0
WireConnection;180;1;177;0
WireConnection;180;2;179;0
WireConnection;167;0;97;0
WireConnection;92;1;96;0
WireConnection;262;0;260;0
WireConnection;315;0;38;3
WireConnection;314;0;38;2
WireConnection;312;0;89;1
WireConnection;52;0;149;0
WireConnection;52;1;47;0
WireConnection;52;2;50;0
WireConnection;20;0;147;0
WireConnection;20;1;19;0
WireConnection;20;2;17;0
WireConnection;323;0;89;3
WireConnection;98;0;92;0
WireConnection;98;1;168;0
WireConnection;318;0;38;4
WireConnection;318;1;317;0
WireConnection;325;0;89;4
WireConnection;325;1;327;0
WireConnection;324;0;89;2
WireConnection;244;0;38;1
WireConnection;181;0;180;0
WireConnection;246;0;98;0
WireConnection;326;0;312;0
WireConnection;326;1;324;0
WireConnection;326;2;323;0
WireConnection;326;3;325;0
WireConnection;313;0;244;0
WireConnection;313;1;314;0
WireConnection;313;2;315;0
WireConnection;313;3;318;0
WireConnection;151;0;52;0
WireConnection;189;0;181;0
WireConnection;189;1;262;0
WireConnection;150;0;20;0
WireConnection;217;0;189;0
WireConnection;236;0;233;0
WireConnection;236;1;235;0
WireConnection;236;2;234;0
WireConnection;73;0;71;0
WireConnection;73;1;72;0
WireConnection;73;2;144;0
WireConnection;6;0;8;0
WireConnection;6;1;7;0
WireConnection;6;2;143;0
WireConnection;160;0;151;0
WireConnection;160;1;150;0
WireConnection;245;0;89;0
WireConnection;245;1;326;0
WireConnection;285;0;262;0
WireConnection;285;1;240;0
WireConnection;243;0;38;0
WireConnection;243;1;313;0
WireConnection;247;0;98;0
WireConnection;247;1;246;0
WireConnection;126;0;245;0
WireConnection;191;0;217;0
WireConnection;237;0;236;0
WireConnection;123;0;6;0
WireConnection;194;0;193;0
WireConnection;131;0;243;0
WireConnection;121;0;73;0
WireConnection;127;0;247;0
WireConnection;161;0;160;0
WireConnection;223;0;285;0
WireConnection;229;0;230;0
WireConnection;221;0;228;0
WireConnection;221;1;231;0
WireConnection;195;0;196;0
WireConnection;195;1;197;0
WireConnection;39;0;156;0
WireConnection;39;1;130;0
WireConnection;39;2;124;0
WireConnection;91;0;129;0
WireConnection;91;1;128;0
WireConnection;91;2;154;0
WireConnection;91;3;241;0
WireConnection;57;0;122;0
WireConnection;57;1;162;0
WireConnection;398;0;221;0
WireConnection;394;0;195;0
WireConnection;390;0;39;0
WireConnection;386;0;57;0
WireConnection;383;0;91;0
WireConnection;388;0;386;3
WireConnection;388;1;387;0
WireConnection;396;0;394;3
WireConnection;396;1;395;0
WireConnection;400;0;398;3
WireConnection;400;1;399;0
WireConnection;392;0;390;3
WireConnection;392;1;391;0
WireConnection;384;0;383;3
WireConnection;384;1;382;0
WireConnection;393;0;390;0
WireConnection;393;1;390;1
WireConnection;393;2;390;2
WireConnection;393;3;392;0
WireConnection;397;0;394;0
WireConnection;397;1;394;1
WireConnection;397;2;394;2
WireConnection;397;3;396;0
WireConnection;389;0;386;0
WireConnection;389;1;386;1
WireConnection;389;2;386;2
WireConnection;389;3;388;0
WireConnection;401;0;398;0
WireConnection;401;1;398;1
WireConnection;401;2;398;2
WireConnection;401;3;400;0
WireConnection;385;0;383;0
WireConnection;385;1;383;1
WireConnection;385;2;383;2
WireConnection;385;3;384;0
WireConnection;59;0;385;0
WireConnection;59;1;389;0
WireConnection;59;2;393;0
WireConnection;59;3;397;0
WireConnection;59;4;401;0
WireConnection;372;0;59;0
WireConnection;377;0;374;0
WireConnection;373;0;372;3
WireConnection;373;1;376;0
WireConnection;375;0;372;0
WireConnection;375;1;372;1
WireConnection;375;2;372;2
WireConnection;375;3;373;0
WireConnection;215;0;47;0
WireConnection;215;1;50;0
WireConnection;216;0;215;0
WireConnection;371;0;375;0
ASEEND*/
//CHKSM=9987FC46D0EBFB2AC6738465F696227051D82DB7