package studyThreeD
{
	import flash.display.BitmapData;
	import flash.display.GraphicsTrianglePath;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.TriangleCulling;
	import flash.events.Event;
	import flash.geom.Vector3D;
	
	public class threeD extends MovieClip
	{
		private var _Bmpsource:BitmapData = new IMG_0014(0, 0)//原始图像数据
		private var _triangles:GraphicsTrianglePath;        //存取三角形数据
		private var _tempmc:Sprite = new Sprite()
		private var _pointitem:Array = new Array()   //4个空间中的点
		private var _newpointitem:Array=new Array()   //旋转后得到点的坐标
		private var _br:Number=200  //焦距以后在镜头里必须要的参数，在这里因为镜头角度都为0所以省去其它
		private var _r:Number=0   //角度
		
		public function threeD() {
			_triangles = new GraphicsTrianglePath(new Vector.<Number>(), new Vector.<int>(), new Vector.<Number>(),TriangleCulling.POSITIVE );
			
			//4个空间中的点
			_pointitem.push(new Vector3D( -100, 50, -50) );    
			_pointitem.push(new Vector3D( -100, -50, -50) );
			_pointitem.push(new Vector3D( 100, -50, 50) );
			_pointitem.push(new Vector3D( 100, 50, 50) );
			
			_newpointitem.push(new Vector3D( -100, 50, 0) );    
			_newpointitem.push(new Vector3D( -100, -50, 0) );
			_newpointitem.push(new Vector3D( 100, -50, 0) );
			_newpointitem.push(new Vector3D( 100, 50, 0) );
			
			
			//舞台上4个点的位置  因为要从三维点从得到映射到舞台上的点, (舞台就是镜头像的位置)
			
			_triangles.vertices.push(0, 0);
			_triangles.vertices.push(0, 0);
			_triangles.vertices.push(0, 0);
			_triangles.vertices.push(0, 0);
			
			//4个点对应该的贴图
			_triangles.uvtData.push(0, 0);
			_triangles.uvtData.push(0, 1);
			_triangles.uvtData.push(1, 1);
			_triangles.uvtData.push(1, 0);
			
			//表示有两个三角形，及三个点对应该上面数级的位置
			_triangles.indices.push(0, 1, 2);
			_triangles.indices.push(0, 2, 3);
			
			this.addChild(_tempmc);
			
			_tempmc.x = 300;
			_tempmc.y = 200;
			
			
			this.addEventListener(Event.ENTER_FRAME,_on_Enter_Frame)
			
		}
		private function _on_Enter_Frame(evt:Event) {
			_r++
			for (var i in _pointitem) {
				
				_newpointitem[i].x = (Math.cos(_r * Math.PI / 180) * _pointitem[i].x + Math.sin(_r * Math.PI / 180) * _pointitem[i].z);
				_newpointitem[i].z = (Math.sin(_r * Math.PI / 180) * _pointitem[i].x + Math.cos(_r * Math.PI / 180) * _pointitem[i].z);
				
				var _obj = transform3d_to_2d(_newpointitem[i])
				
				_triangles.vertices[i * 2 + 0] = _obj.x;
				_triangles.vertices[i * 2 + 1] = _obj.y;
				
			}
			
			_draw_pic();
		}
		private function transform3d_to_2d(_point:Vector3D) {
			//将三维中的点映射到镜头上的位 置 
			return {x:_point.x / (_point.z+_br) * _br ,y:-_point.y / (_point.z+_br) * _br}
			
		}
		public function _draw_pic() {
			_tempmc.graphics.clear()
			_tempmc.graphics.beginBitmapFill(_Bmpsource);    //贴图文件，BitmapData
			_tempmc.graphics.lineStyle(1,0x4564587)
			_tempmc.graphics.drawTriangles(_triangles.vertices, _triangles.indices, _triangles.uvtData, TriangleCulling.POSITIVE ); // 画图函数
		}

	}
}