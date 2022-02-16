## 1.1.8 (2019/09/12)
* Relax rails dependency ([#78](https://github.com/sungwoncho/has_friendship/pull/78)) [@MaximeD](https://github.com/MaximeD)
* Bump loofah

## 1.1.7 (2019/09/12)
* Adds rails 6 compatibility ([#68](https://github.com/sungwoncho/has_friendship/pull/68)) [@Yinfei](https://github.com/Yinfei)

## 1.1.6 (2018/12/08)
* Add create destroy after hook specs ([#66](https://github.com/sungwoncho/has_friendship/pull/66)) [@chevinbrown](https://github.com/chevinbrown)
* Fix migration copying command in README.md ([#65](https://github.com/sungwoncho/has_friendship/pull/65)) [@KubaSemczuk](https://github.com/KubaSemczuk)
* Stop overriding callback methods if they're present ([#56](https://github.com/sungwoncho/has_friendship/pull/56)) [@skycocker](https://github.com/skycocker)

## 1.1.5 (2018/12/01)
* Corrects unique index between friendable_id and friend_id

There was a typo in the migration of version 1.1.4 and the migration was not tested or reviewed.

## 1.1.4 (2018/11/29)(yanked)

* Adds unique index between friendable_id and friend_id to prevent duplicate friendships. ([#64](https://github.com/sungwoncho/has_friendship/pull/64)) [@xilefff](https://github.com/xilefff)

## 1.1.3 (2018/11/3)

* Add rails engine so that migrations will automatically be pulled in by rails ([#60](https://github.com/sungwoncho/has_friendship/pull/60)) [@chevinbrown](https://github.com/chevinbrown)

## 1.1.2 (2018/11/3)

* Allow Rails 5.2 ([#57](https://github.com/sungwoncho/has_friendship/pull/57)) [@jmajonis](https://github.com/jmajonis)

## 1.1.1 (2017/5/6)

* Allow Rails 5.1.x ([#47](https://github.com/sungwoncho/has_friendship/pull/47)) [@mswiszcz](https://github.com/mswiszcz)

## 1.1.0 (2017/5/6)

* Implement callbacks for friendship state change ([#41](https://github.com/sungwoncho/has_friendship/pull/41)) [@sbadura](https://github.com/sbadura)

## 1.0.2 (2016/5/31)

* Accept Rails 5.0.x as a dependency [@adambutler](https://github.com/adambutler)

## 1.0.1 (2016/5/14)

* Fix missing methods issue ([#28](https://github.com/sungwoncho/has_friendship/pull/28)) [@f-anthonioz](https://github.com/f-anthonioz)
* Add down method to a migration ([#30](https://github.com/sungwoncho/has_friendship/pull/30)) [@f-anthonioz](https://github.com/f-anthonioz)

## 1.0.0 (2016/5/7)

* Add a new migration for implementing state machine ([#27](https://github.com/sungwoncho/has_friendship/pull/27)) [@ArmandoMendoza](https://github.com/ArmandoMendoza)

## 0.1.4 (2016/4/17)

* Implement state machine for friendship status ([#24](https://github.com/sungwoncho/has_friendship/pull/24)) [@ArmandoMendoza](https://github.com/ArmandoMendoza)

## 0.1.3 (2016/4/5)

* Fix `blocked_friends` ([#23](https://github.com/sungwoncho/has_friendship/pull/23))

## 0.1.2 (2016/3/6)

* Fix friends_with to return true only when an 'accepted' friendship exists ([f73d1e](https://github.com/sungwoncho/has_friendship/commit/f73d1ef2149c06135f99e0ec18457c5aa9dd85a1))

## 0.1.1 (2016/2/20)

* Fix overlapping migration timestamp [#17](https://github.com/sungwoncho/has_friendship/pull/17)

## 0.1.0 (2015/12/5)

* Rails 4.x support (#11)
* Add feature to block/unblock a friendable (#12)

## 0.0.3 (2015/7/29)

* Fix `#friends_with?` logic. (#5)

## 0.0.2 (2015/7/19)

* Add `#friends_with?` to check if an accepted friendship exists. (#5)

## 0.0.1 (2014/12/2)

* Initial release
