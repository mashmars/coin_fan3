<?php
namespace Home\Controller;
use Think\Controller;

class LoginController extends Controller
{

    /**
     * 手机登录
     */

    /**
     * 登录发送验证码
     */
    public function ajax_send_sms_login()
    {
        $phone = I('post.phone');
        //判断手机号是否存在
        $id = M('user')->where(array('phone' => $phone))->getField('id');
        if (!$id) {
            echo ajax_return(0, '手机号未注册');
            exit;
        }
		
		session($phone.'login',123);
        echo ajax_return(1,'短信验证码发送成功,测试验证码是123');exit;
		
        $code = mt_rand(10000, 99999);
        $result = send_sms('79413', $phone, $code);
        if ($result['info'] == 'success') {
            session($phone . 'login', $code);
            echo ajax_return(1, '短信验证码发送成功');
        } else {
            echo ajax_return(0, $result['msg']);
        }
    }

    /**
     * 手机号验证码登录
     */
    public function ajax_login_phone()
    {
        $phone = I('post.phone');
        $sms = I('post.sms');

        if ($sms != session($phone . 'login')) {
            echo ajax_return(0, '短信验证码不正确');
            exit;
        }
        //判断手机号是否存在
        $id = M('user')->where(array('phone' => $phone))->getField('id');
        if (!$id) {
            echo ajax_return(0, '手机号未注册');
            exit;
        }
        //可以登录
        echo ajax_return(1, '登录成功');
        session('userid', $id);
        session('phone', $phone);
        session($phone . 'login', null);
    }

    /**
     * 手机号密码登录
     */
    public function ajax_login_password()
    {
        $phone = I('post.phone');
        $password = I('post.password');

        if ($password == '') {
            echo ajax_return(0, '登录密码不能为空');
            exit;
        }
        //判断手机号是否存在
        $info = M('user')->where(array('phone' => $phone))->find();
        if (!$info) {
            echo ajax_return(0, '手机号未注册');
            exit;
        }
        if ($info['password'] != md5($password)) {
            echo ajax_return(0, '登录密码不正确');
            exit;
        }
        //可以登录
        echo ajax_return(1, '登录成功');
        session('userid', $info['id']);
        session('phone', $phone);
    }

    /**
     * 找回密码发送短信验证码
     */
    public function ajax_send_sms_find()
    {
        $phone = I('post.phone');
        //判断手机号是否存在
        $id = M('user')->where(array('phone' => $phone))->getField('id');
        if (!$id) {
            echo ajax_return(0, '手机号不存在');
            exit;
        }
		
		session($phone.'find',123);
        echo ajax_return(1,'短信验证码发送成功,测试验证码是123');exit;
		
        $code = mt_rand(10000, 99999);
        $result = send_sms('79413', $phone, $code);
        if ($result['info'] == 'success') {
            session($phone . 'find', $code);
            echo ajax_return(1, '短信验证码发送成功');
        } else {
            echo ajax_return(0, $result['msg']);
        }
    }

    /**
     * 找回密码提交
     */
    public function ajax_find_password()
    {
        $phone = I('post.phone');
        $sms = I('post.sms');
        $newpassword = I('post.newpassword');
        $newpassword2 = I('post.newpassword2');
        if ($sms != session($phone . 'find')) {
            echo ajax_return(0, '短信验证码不正确');
            exit;
        }
        if($newpassword != $newpassword2 || $newpassword == ''){
            echo ajax_return(0,'两次密码输入不一致');exit;
        }
        //判断手机号是否存在
        $info = M('user')->where(array('phone' => $phone))->find();
        if (!$info) {
            echo ajax_return(0, '手机号未注册');
            exit;
        }
        //可以更改
        $res = M('user')->where(array('id'=>$info['id']))->setField(array('password'=>md5($newpassword)));
        if($res){
            echo ajax_return(1, '修改成功');
            session($phone . 'find',null);
        }else{
            echo ajax_return(0, '修改失败');
        }
    }

	public function register(){
		$this->display();
	}
	//发送注册短信验证
    public function ajax_send_sms()
    {
        $phone = I('post.phone');
        //判断手机号是否存在
        $id = M('user')->where(array('phone'=>$phone))->getField('id');
        if($id){
            echo ajax_return(0,'手机号已注册');exit;
        }
		
		session($phone.'reg',123);
        echo ajax_return(1,'短信验证码发送成功,测试验证码是123');exit;
        
		$code = mt_rand(10000,99999);
        $result = send_sms('79413',$phone,$code);
        if($result['info'] == 'success'){
            session($phone.'reg',$code);
            echo ajax_return(1,'短信验证码发送成功');
        }else{
            echo ajax_return(0,$result['msg']);
        }
    }
	//注册前获取邀请人信息ajax获取到当前邀请人下面有人，就返回状态，让一区二区显示出来就可以了 //暂时不用
	public function ajax_getrefer()
	{
		$refer = I('post.refer');
		$id = M('user')->where(array('phone'=>$refer))->getField('id');
		if(!$id){
			echo json_encode(array('info'=>'other','msg'=>'邀请人手机号不正确'));exit;
		}else{
			//判断当前用户下面有人没 有的话 返回success 否则返回erroe
			$zone = M('user_zone')->where(array('pid'=>$id))->find();
			if($zone){
				echo ajax_return(1,'没人');
			}else{
				echo ajax_return(0,'有人');
			}
		}
	}
    //注册
    public function ajax_register()
    {
        $phone = I('post.phone');
        $sms = I('post.sms');
        $realname = I('post.realname');
        $password = I('post.password');
        $paypassword = I('post.paypassword');
        $refer = I('post.refer');
        $zone = I('post.zone');

        /**
         * 注册流程，
         * 1，必要条件验证
         * 2，判断短信验证码是否存在
         * 3，判断手机号是否存在 以及上级手机号是否存在
         * 4，注册成功 同时建立资产表
         * 5, 注册成功 分区表（一直按下级的A区分配绑定）
         */
        //1
        if(!$phone){
            echo ajax_return(0,'手机号不正确');exit;
        }
		if(!$refer){
            echo ajax_return(0,'推荐人手机号不能为空');exit;
        }
        if($sms == ''){
            echo ajax_return(0,'短信验证码不能为空');exit;
        }
        if(!$password){
            echo ajax_return(0,'登录密码设置不正确');exit;
        }
        if(!$paypassword){
            echo ajax_return(0,'支付密码设置不正确');exit;
        }
        if($password == $paypassword){
            echo ajax_return(0,'登录密码和支付密码不能一样');exit;
        }
        if($zone != 1 && $zone !=2 && $zone !=3){
            echo ajax_return(0,'请求有误');exit;
        }
        //2
        if($sms != session($phone . 'reg')){
            echo ajax_return(0,'短信验证码不正确');exit;
        }
        //3
        $id = M('user')->where(array('phone'=>$phone))->getField('id');
        if($id){
            echo ajax_return(0,'手机号已注册');exit;
        }
        $id = M('user')->where(array('phone'=>$refer))->getField('id');
		if(!$id){
			echo ajax_return(0,'推荐人手机号不存在');exit;
		}else{
			$pid = $id;
		}
        //4
        $mo = M();
        $mo->startTrans();
        $rs = array();
        //注册成功
        $rs[] = $mo->table('user')->add(array('phone'=>$phone,'username'=>$phone,'password'=>md5($password),'paypassword'=>md5($paypassword),'pid'=>$pid,'realname'=>$realname,'createdate'=>time()));
        //插入资产表
        $rs[] = $mo->table('user_coin')->add(array('userid'=>$rs[0]));
        //开始分区
        $rs[] = $this->user_zone($rs[0],$pid,$pid,$zone);

        if(check_arr($rs)){
            $mo->commit();
            session($phone . 'reg' ,null);
            echo ajax_return(1,'注册成功');
        }else{
            $mo->rollback();
            echo ajax_return(0,'注册失败');
        }

    }
    /**
     * 注册分区 规则如下
     * 注册的时候选择一区 二区 三区，放到这个区的大区的最下面  （大区 中区 小区）
     */
    private  function user_zone($userid,$ownid,$pid,$zone)
    {
        if($pid == 0){ //暂时不用 因为必须有上级
            $res = M('user_zone')->add(array('userid'=>$userid,'ownid'=>0,'pid'=>0,'zone'=>0,'level'=>1,'pids'=>$pid.','));

        }else{
			//新增如果推荐人下面没有人 不管提交的zone是哪个区 默认为1区
			$shangji = M('user_zone')->where(array('userid'=>$pid))->find();
			$user_zone = M('user_zone')->where(array('pid'=>$pid,'zone'=>$zone))->find();
			if(!$user_zone){
				//$zone = 1; //这儿是默认1区，
				$res = M('user_zone')->add(array('userid'=>$userid,'ownid'=>$ownid,'pid'=>$pid,'zone'=>$zone,'level'=>$shangji['level']+1,'pids'=>$shangji['pids'] . $userid . ','));
			}else{
				$res = $this->add_zone($userid,$ownid,$user_zone['userid'],$zone); //此处的第三个参数是指 要放的pid的指定区的会员下面的最大区
			}
            

        }
        if(!$res){
            return false;
        }
        return true;
    }
    /**
     注册的时候选择一区 二区 三区，放到这个区的大区的最下面  （大区 中区 小区） 这儿是先找到大区，然后再找到最下面的那个人 放到他下面
     * 加行锁 防止同时两个人挂一个人下面的情况
     * $userid 注册会员id $ownid 推荐人id $pid 节点人的id $zone 要找的哪个区 遍历用 （只要推荐人下面没人 直接放一区 放上面了）
     */
    private function add_zone($userid,$ownid,$pid,$zone)
    {
		$users = M('user_zone')->where(array('pid'=>$pid))->order('zone asc')->select(); //按 1 2 3 区排序
		if(!$users){
			$shangji = M('user_zone')->where(array('userid'=>$pid))->find();
			$res = M('user_zone')->add(array('userid'=>$userid,'ownid'=>$ownid,'pid'=>$pid,'zone'=>1,'level'=>$shangji['level']+1,'pids'=>$shangji['pids'] . $userid . ','));
			return $res;
		}
		$zones = array();//所有区信息
		$biger = 0; //大区的用户id
		$tmp = -1; //考虑下面区业绩是0 所以给默认值是负值 必须
		foreach($users as $user){
			$data = $this->get_xiaji($user['userid']);
			$zones[$user['userid']]=$data;
		}
		foreach($zones as $k=>$v){
			if($v>$tmp){ //不能用大于等于 因为默认给1区分
				$tmp = $v;
				$biger = $k;
			}
		}
		//找到了大区的userid biger
		//添加到这人的最下面
		$map['_string']="FIND_IN_SET($biger,pids)";
		$deth = M('user_zone')->where($map)->order('level desc')->find();
		//此处放到最大区的最小面，貌似一直就是1区的位置。。 这个逻辑有点。。
		$res = M('user_zone')->add(array('userid'=>$userid,'ownid'=>$ownid,'pid'=>$deth['userid'],'zone'=>1,'level'=>$deth['level']+1,'pids'=>$deth['pids'].$userid.','));
		return $res;
    }
	//获取三条线
	public function get_xiaji($userid)
	{		
		$users = $this->get_small_zone($userid);
		$qu_total = M('user_coin')->where(array('userid'=>array('in',$users)))->sum('lth');
		return $qu_total;
	}
	//获取区用户
	public function get_small_zone($userid,$new=true)
	{
		static $users = array();
		if($new){
			$users = array();//必须释放
		}
		array_push($users,$userid);
		$user_xiaji = M('user_zone')->where(array('pid'=>$userid))->getField('userid',true);
		if($user_xiaji){
			foreach($user_xiaji as $user){
				$this->get_small_zone($user,false);
			}				
		}
		return $users;
	}
	
	public function test(){
		$biger = 3;
		$map['_string']="FIND_IN_SET($biger,pids)";
		//$deth = M()->query("select * from user_zone  where find_in_set({$biger},pids) order by level desc limit 1");
		$deth = M('user_zone')->where($map)->order('level desc')->find();
		var_dump($deth);
	}
	
}