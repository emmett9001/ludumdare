package{
    import org.flixel.*;

    public class Convo {

        public var choices:Array;
        public var choicePos:Array;
        public var choicesRef:Array;
        public var momWords:FlxText;
        public var selectX:Number;
        public var selectY:Number;
        public var selector:Selector;
        public var curBranch:ConvoBranch;

        public function Convo(ref:ConvoBranch):void{
            choicesRef = ref.responses;
            curBranch = ref;
            choices = new Array(choicesRef.length);
            choicePos = new Array(choicesRef.length);
        }

        public function momSays():void{
            var words:String = this.curBranch.momSentence;
            momWords = new FlxText(13,75,130,words);
            FlxG.state.add(momWords);
        }

        public function newConvo(x:int,y:int):void{
            this.selectX = x;
            this.selectY = y;
            var yCalc:int = y;
            for(var i:int = 0; i < choicesRef.length; i++){
                yCalc += 30;
                choices[i] = oneReply(choicesRef[i],x,yCalc);
                choicePos[i] = yCalc + 5;
            }
        }

        public function oneReply(i:String,x:int,y:int):FlxText{
            var newReply:FlxText = new FlxText(x,y,150,i);
            FlxG.state.add(newReply);
            return newReply;
        }

        public function start():void{
            this.momSays();
            var xArr:Array = new Array();
            for (var i:int = 0; i < this.choicePos.length; i++) {
                xArr.push(this.selectX-5);
            }
            selector = new Selector(xArr,this.choicePos);
            FlxG.state.add(selector);
        }

        public function kill():void{
            for(var i:int = 0; i < choicesRef.length; i++){
                if (choices[i]) {
                    choices[i].kill();
                }
            }
            selector.kill();
            momWords.kill();
        }

        public function getInput():String{
            if (FlxG.keys.justPressed("ENTER")){
                return curBranch.responsePointers[this.selector.getIndices()[1]];
            }
            return PlayState.NO_RESULT;
        }
    }
}
