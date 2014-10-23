package conponents
{
	public class SortAlg
	{
		public function SortAlg()
		{
			var nums:Array = [];
			for(var i:int=0 ; i<1000 ; i++){
				nums.push(int(Math.random()*1000));
			}
			trace(nums);
			printTime();
			trace(mergeSort(nums));
			printTime();
		}
		
		private function printTime():void {
			var dt:Date = new Date();
			trace(dt.getSeconds()+":"+dt.getMilliseconds());
		}
		
		private function insertSort(ary:Array):Array {
			var rankedAry:Array = [];
			for(var i:int=0 ; i<ary.length ; i++){
				if(rankedAry.length==0){
					rankedAry.push(ary[i]);
				}else{
					for(var j:int=0 ; j<rankedAry.length ; j++){
						if(ary[i]>rankedAry[j]&&j<rankedAry.length-1){
							var rests:Array = rankedAry.splice(j,rankedAry.length-j);
							rankedAry = rankedAry.concat(ary[i],rests);
							break;
						}else if(j==rankedAry.length-1){
							rankedAry.push(ary[i]);
							break;
						}
					}
				}
			}
			printTime();
			return rankedAry;
		}
		
		private function quickSort(ary:Array):Array {
			var flag:int=ary.shift();
			var rankedArray:Array = compare(flag,ary);
			printTime();
			return rankedArray;
		}
		private function compare(elet:int,ary:Array):Array {
			var minAry:Array = [];
			var maxAry:Array = [];
			var rankedMaxAry:Array = [];
			var rankedMinAry:Array = [];
			if(ary.length>1){
				for(var i:int=0 ; i<ary.length ; i++){
					if(ary[i]>elet){
						maxAry.push(ary[i]);
					}else{
						minAry.push(ary[i]);
					}
				}
				if(maxAry.length>=1){
					var maxFlag:int = maxAry.shift();
					rankedMaxAry = compare(maxFlag,maxAry)
				}
				if(minAry.length>=1){
					var minFlag:int = minAry.shift();
					rankedMinAry = compare(minFlag,minAry)
				}
				return rankedMaxAry.concat(elet,rankedMinAry);
			}else{
				if(ary.length>0){
					if(elet>ary[0]){
						return [elet,ary[0]];
					}else{
						return [ary[0],elet];
					}
				}else{
					return [elet];
				}
			}
		}
		
		private function simpleSelectionSort(unrankedArr:Array):Array {
			var rankedArr:Array = [];
			var len:int = unrankedArr.length;
			for(var i:int=0 ; i<len ; i++){
				var elet:int = selectMax(unrankedArr[i],unrankedArr);
				rankedArr.push(elet);
			}
			printTime();
			return rankedArr;
		}
		private function selectMax(elet:int, unrankedArr:Array):int
		{
			var max:int=elet;
			var index:int=0;
			for(var i:int=0 ; i<unrankedArr.length ; i++){
				if(elet<unrankedArr[i]){
					max = unrankedArr[i];
					elet = max;
					index = i;
				}
			}
			unrankedArr.splice(index,1);
			return max;
		}
		
		private function tournamentSort(unrankedArr:Array):Array {
			var rankedArr:Array = [];
			var rests:Array = unrankedArr;
			var news:Array = [];
			var index:int=0;
			var max:int=0;
			while(rests.length>0){
				news=[];
				for(var i:int=0 ; i<rests.length ; i+=2){
					if(i+1<unrankedArr.length){
						max = rests[i]>rests[i+1]?rests[i]:rests[i+1];
						news.push(max);
					}
				}
				trace(news);
				rests = news;
				if(rests.length<2){
					max = rests[0];
					for(i=0;i<unrankedArr.length;i++){
						if(max==unrankedArr[i]){
							index = i;
						}
					}
					unrankedArr.splice(index,1);
					rankedArr.push(max);
					rests = unrankedArr;
				}
			}
			printTime();
			return rankedArr;
		}
		
		
		private function mergeSort(arr:Array):Array {
			if(arr.length>1){
				var flag:int;
				var leftSubArr:Array;
				var rightSubArr:Array;
				flag = arr.length*.5;
				leftSubArr = arr.slice(0,flag);
				rightSubArr = arr.slice(flag,arr.length);
				//trace(leftSubArr + " --- " + rightSubArr);
				return merge(mergeSort(leftSubArr),mergeSort(rightSubArr));
			}else{
				if(arr.length==0){
					//trace(" --- ");
					return [];
				}else{
					//trace(arr[0] + " --- ");
					return [arr[0]];
				}
			}
		}
		private function merge(arr1:Array,arr2:Array):Array
		{
			//trace(arr1 + " +++ " + arr2);
			// TODO Auto Generated method stub
			var rankedArr:Array = [];
			var len:int=arr1.length+arr2.length;
			var index:int=0;
			if(arr1.length==0){
				rankedArr = arr2;
			}else if(arr2.length==0){
				rankedArr = arr1;
			}else{
				for(index=0 ; index<len ; index++){
					if(arr1.length>0&&arr2.length>0){
						if(arr1[0]>arr2[0]){
							rankedArr.push(arr2.shift());
						}else{
							rankedArr.push(arr1.shift());
						}
					}else if(arr1.length>0){
						rankedArr.push(arr1.shift());
					}else if(arr2.length>0){
						rankedArr.push(arr2.shift());
					}
				}
			}
			//trace(rankedArr);
			return rankedArr;
		}
	}
}