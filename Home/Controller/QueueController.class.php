<?php
namespace Home\Controller;
use Think\Controller;

class QueueController extends Controller
{
	
	public function dd(){
		Vendor("Move.ext.client");
        $client = new \client('...','...', '127.0.0.1', 29316, 5, [], 1);
        $json = $client->getinfo();

        if (!isset($json['version']) || !$json['version']) {
            echo '###ERR#####*****  connect fail  ***** ####ERR####>' . "\n";exit;
        }
        $listtransactions = $client->listtransactions('*', 100, 0);
        echo 'listtransactions:' . count($listtransactions) . "\n";
        krsort($listtransactions);
        echo '<pre>';
        var_dump($listtransactions);exit;
        foreach ($listtransactions as $trans) {

            if (M('Myzr')->where(array('txid' => $trans['txid'], 'status' => '1'))->find()) {
                echo 'txid had found continue' . "\n";
                continue;
            }

            echo 'all check ok ' . "\n";

            if ($trans['category'] == 'receive') {
                //如果是接收的 通过账户获取用户信息
               /* if (!($user = M('user')->where(array('phone' => $trans['account']))->find())) {
                    echo 'no account find continue' . "\n";
                    continue;
                }*/
                if (!($user = M('user_coin')->where(array('lthb' => $trans['address']))->find())) {
                    echo 'no account find continue' . "\n";
                    continue;
                }
                print_r($trans);
                echo 'start receive do:' . "\n";
                $sfee = 0;
                $true_amount = $trans['amount'];

                //经过多少次确认
                if ($trans['confirmations'] < 5) {

                    echo 'confirmations <  c_zr_dz continue' . "\n";

                    if ($res = M('myzr')->where(array('txid' => $trans['txid']))->find()) {
                        M('myzr')->save(array('id' => $res['id'], 'createtime' => time(), 'status' => intval($trans['confirmations'] - 5)));
                    }else {
                        M('myzr')->add(array('userid' => $user['userid'], 'address' => $trans['address'] , 'txid' => $trans['txid'], 'num' => $true_amount, 'createdate' => time(), 'status' => intval($trans['confirmations'] - 5)));
                    }

                    continue;
                }
                else {
                    echo 'confirmations full' . "\n";
                }

                $mo = M();
                $mo->startTrans();
                $rs = array();
                $rs[] = $mo->table('user_coin')->where(array('userid' => $user['userid']))->setInc('lth', $trans['amount']);

                if ($res = $mo->table('myzr')->where(array('txid' => $trans['txid']))->find()) {
                    echo 'myzr find and set status 1';
                    $rs[] = $mo->table('myzr')->save(array('id' => $res['id'], 'createdate' => time(), 'status' => 1));
                }
                else {
                    echo 'myzr not find and add a new myzr' . "\n";
                    $rs[] = $mo->table('myzr')->add(array('userid' => $user['userid'], 'address' => $trans['address'], 'txid' => $trans['txid'], 'num' => $true_amount, 'createdate' => time(), 'status' => 1));
                }

                if (check_arr($rs)) {
                    $mo->commit();
                    echo $trans['address'] . ' receive ok '  . $trans['address'];

                    echo 'commit ok' . "\n";
                }else {
                    echo $trans['address'] . 'receive fail ' . $trans['address'];

                    $mo->rollback();
                    print_r($rs);
                    echo 'rollback ok' . "\n";
                }
            }
            ///////转出
            if ($trans['category'] == 'send') {
                echo 'start send do:' . "\n";

                if (3 <= $trans['confirmations']) {
                    $myzc = M('Myzc')->where(array('address' => $trans['address']))->find();

                    if ($myzc) {
                        if ($myzc['status'] == 0) {
                            M('Myzc')->where(array('id' => $myzc['id']))->save(array('status' => 1,'txid'=>$trans['txid']));
                            echo $trans['amount'] . '成功转出币确定';
                        }
                    }
                }
            }
        }
	}
    /**
     * 钱包检查
     */
    public function qianbao()
    {
        Vendor("Move.ext.client");
       $client = new \client('...','...', '127.0.0.1', 29316, 5, [], 1);
        $json = $client->getinfo();

        if (!isset($json['version']) || !$json['version']) {
            echo '###ERR#####*****  connect fail  ***** ####ERR####>' . "\n";exit;
        }
        $listtransactions = $client->listtransactions('*', 100, 0);
        echo 'listtransactions:' . count($listtransactions) . "\n";
        krsort($listtransactions);
        echo '<pre>';
        //var_dump($listtransactions);exit;
        foreach ($listtransactions as $trans) {

            if (M('Myzr')->where(array('txid' => $trans['txid'], 'status' => '1'))->find()) {
                echo 'txid had found continue' . "\n";
                continue;
            }

            echo 'all check ok ' . "\n";

            if ($trans['category'] == 'receive') {
                //如果是接收的 通过账户获取用户信息
               /* if (!($user = M('user')->where(array('phone' => $trans['account']))->find())) {
                    echo 'no account find continue' . "\n";
                    continue;
                }*/
                if (!($user = M('user_coin')->where(array('lthb' => $trans['address']))->find())) {
                    echo 'no account find continue' . "\n";
                    continue;
                }
                print_r($trans);
                echo 'start receive do:' . "\n";
                $sfee = 0;
                $true_amount = $trans['amount'];

                //经过多少次确认
                if ($trans['confirmations'] < 5) {

                    echo 'confirmations <  c_zr_dz continue' . "\n";

                    if ($res = M('myzr')->where(array('txid' => $trans['txid']))->find()) {
                        M('myzr')->save(array('id' => $res['id'], 'createtime' => time(), 'status' => intval($trans['confirmations'] - 5)));
                    }else {
                        M('myzr')->add(array('userid' => $user['userid'], 'address' => $trans['address'] , 'txid' => $trans['txid'], 'num' => $true_amount, 'createdate' => time(), 'status' => intval($trans['confirmations'] - 5)));
                    }

                    continue;
                }
                else {
                    echo 'confirmations full' . "\n";
                }

                $mo = M();
                $mo->startTrans();
                $rs = array();
                $rs[] = $mo->table('user_coin')->where(array('userid' => $user['userid']))->setInc('lth', $trans['amount']);

                if ($res = $mo->table('myzr')->where(array('txid' => $trans['txid']))->find()) {
                    echo 'myzr find and set status 1';
                    $rs[] = $mo->table('myzr')->save(array('id' => $res['id'], 'createdate' => time(), 'status' => 1));
                }
                else {
                    echo 'myzr not find and add a new myzr' . "\n";
                    $rs[] = $mo->table('myzr')->add(array('userid' => $user['userid'], 'address' => $trans['address'], 'txid' => $trans['txid'], 'num' => $true_amount, 'createdate' => time(), 'status' => 1));
                }

                if (check_arr($rs)) {
                    $mo->commit();
                    echo $trans['address'] . ' receive ok '  . $trans['address'];

                    echo 'commit ok' . "\n";
                }else {
                    echo $trans['address'] . 'receive fail ' . $trans['address'];

                    $mo->rollback();
                    print_r($rs);
                    echo 'rollback ok' . "\n";
                }
            }
            ///////转出
            if ($trans['category'] == 'send') {
                echo 'start send do:' . "\n";

                if (3 <= $trans['confirmations']) {
                    $myzc = M('Myzc')->where(array('address' => $trans['address']))->find();

                    if ($myzc) {
                        if ($myzc['status'] == 0) {
                            M('Myzc')->where(array('id' => $myzc['id']))->save(array('status' => 1,'txid'=>$trans['txid']));
                            echo $trans['amount'] . '成功转出币确定';
                        }
                    }
                }
            }
        }
    }
	
	/**
	 *分红
	 */
	public function start_fh()
	{
		$sys_jtfh = M('sys_jtfh')->where(array('status=1'))->select(); //所有静态分红
		$sys_dtfh = M('sys_dtfh')->where(array('status=1'))->select(); //所有动态分红
		//所有币数
		$user_coin = M('user_coin')->where(array('lth'=>array('gt',0)))->select();
        //核对每天只能分红一次
        $start = strtotime(date('Y-m-d'));
        $end = $start + 24*3600-1;
		//个人分红上限 5000  或者是 个人持币对应区间的下限*50% 那个小按哪个为准
		$limit = 5000; //		
		
		$count = count($user_coin); //本次分红总人数 包括没有达到静态分红的最小值的情况
		$jt_deal=0;//已处理的静态人数
		$dt_deal=0;//已处理的动态人数
		
		foreach($user_coin as $coin)
		{
			$yfh = 0; //已分红的币数
			$gr_limit=0; //个人限制  个人分红上限 5000  或者是 个人持币对应区间的下限*50% 那个小按哪个为准
			$limit1=0; //个人持币对应区间的下限*50%
			if($coin['lth']  == 0){
			    continue;
            }
            //保证每天只能分红一次
            $is_fh = M('sys_fh_log')->where(array('userid'=>$coin['userid'],'createdate'=>array('between',array($start,$end))))->getField('type',true);
            //var_dump($coin['userid'] . '---');var_dump($is_fh);continue;
			
			$jt_num =0;//本次分红的币数
			$dt_num =0;//本次分红的币数
			$jtfh=array(); //满足条件的
			$dtfh = array();
			foreach($sys_jtfh as $v){
				if((int)$coin['lth'] >= $v['minnum'] && (int)$coin['lth'] <= $v['maxnum']){
					$jtfh = $v;
					break;
				}
			}
			
			if($jtfh){ //开始静态分红
                if(in_array(1,$is_fh)){
                    continue;
                }
				$jt_num = $jtfh['bl'] * $coin['lth'] ; //考虑保留几位小数 TODO
                $jt_num = sprintf("%.2f",substr(sprintf("%.4f", $jt_num), 0, -2)); //本次分红数量
				$limit1 = $jtfh['minnum']*0.5;
				$gr_limit = ($limit > $limit1) ? $limit1 : $limit;
				//实际的分红数
				$jt_num = ($jt_num + $yfh) > $gr_limit ? ($gr_limit - $yfh) : $jt_num;
				//新增静态每次最多是108个
				$jt_num = ($jt_num > 108) ? 108 : $jt_num ;
                $m = M();
				$m->startTrans();
				$rs = array();
				$rs[] = $m->table('user_coin')->where(array('id'=>$coin['id']))->setInc('lth',$jt_num);
				$rs[] = $m->table('sys_fh_log')->add(array(
					'userid'=>$coin['userid'],
					'type'=>1,
					'current'=>$coin['lth'],
					'fh_id'=>$jtfh['id'],
					'bl'=>$jtfh['bl'],
					'num'=>$jt_num,
					'createdate'=>time()
				));
				if(check_arr($rs)){
					$m->commit();
					$jt_deal++;
					$yfh += $jt_num;
				}else{
					$m->rollback();
				}			
			}
			
			//动态分红开始
            //保证每天只能分红一次
            if(in_array(2,$is_fh)){
                continue;
            }
			//获取动态分红的小区业绩
			$yj = $this->get_xiaji($coin['userid']);
			if(!$yj){ //没有业绩或只有一条线
			    continue;
            }
			foreach($sys_dtfh as $vv){
				if((int)$coin['lth'] >= $vv['minnum'] && (int)$coin['lth'] <= $vv['maxnum']){
					$dtfh = $vv;
					break;
				}
			}
			if($dtfh){ //开始动态分红 保留两位小数				
				$dt_num = $dtfh['bl'] * $yj ; //本次分红的数量 动态是按小区业绩走的 考虑保留几位小数 TODO
                $dt_num = sprintf("%.2f",substr(sprintf("%.4f", $dt_num), 0, -2));
				$limit1 = $dtfh['minnum']*0.5;
				$gr_limit = ($limit > $limit1) ? $limit1 : $limit;				
				//实际的分红数
				$dt_num = ($dt_num + $yfh) > $gr_limit ? ($gr_limit - $yfh) : $dt_num;
				if($dt_num <=0){
					continue;
				}
                $m = M();
                $m->startTrans();
                $rs = array();
                $rs[] = $m->table('user_coin')->where(array('id'=>$coin['id']))->setInc('lth',$dt_num);
                $rs[] = $m->table('sys_fh_log')->add(array(
                    'userid'=>$coin['userid'],
                    'type'=>2,
                    'current'=>$coin['lth'],
                    'fh_id'=>$dtfh['id'],
                    'bl'=>$dtfh['bl'],
                    'num'=>$dt_num,
                    'createdate'=>time()
                ));
                if(check_arr($rs)){
                    $m->commit();
                    $dt_deal++;
                    
                }else{
                    $m->rollback();
                }
            }
		}
        //插入分红校验表 证明本次分红完成
        M('sys_fh_verify')->add(array(
            'count'         => $count,
            'deal_dt'       => $dt_deal,
            'deal_jt'       => $jt_deal,
            'createdate'    => strtotime(date('Y-m-d'))
        ));
		echo 'successful';
    }
	
	//获取两条线
	public function get_xiaji($userid)
	{
		$users = M('user_zone')->where(array('pid'=>$userid))->getField('userid',true);
		if(count($users) <= 1){
			return false;
		}
		//第一个区
		$users_a = $this->get_small_zone($users[0]);
		//第二个区
		$users_b = $this->get_small_zone($users[1]);
		$qu_1_total = M('user_coin')->where(array('userid'=>array('in',$users_a)))->sum('lth');
		$qu_2_total = M('user_coin')->where(array('userid'=>array('in',$users_b)))->sum('lth');
		$xiaoqu = $qu_1_total > $qu_2_total ? $qu_2_total : $qu_1_total;//小区总持币数
		
		return $xiaoqu;
	}
	//获取小区用户
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
		
	
	
}