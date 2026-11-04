<?php

/**
 * This file is part of Tak-Me CMS system.
 *
 * @author  Taka Goto <www.plus-5.com>
 * @copyright (c)2018 PlusFive (https://www.plus-5.com)
 */

namespace plugin\FixedForm;

use Gsnowhawk\Common\Lang;

class Receive extends Response
{
    public function save()
    {
        $redirect_type = 'redirect';
        $redirect_mode = (!empty($this->request->param('redirect_mode')))
            ? $this->request->param('redirect_mode')
            : 'fixed-form~response';

        if ($referer = $this->request->param('script_referer')) {
            $redirect_mode = $referer;
            $redirect_type = 'referer';
        }

        $message = 'SUCCESS_SAVED';
        $status = 0;
        $options = [];
        $response = [[$this, 'redirect'], $redirect_mode, $redirect_type];

        if (!parent::save()) {
            $message = 'FAILED_SAVE';
            $status = 1;
            $options = [
                [[$this->view, 'bind'], ['err', $this->app->err]],
            ];
            $response = [[$this, 'edit'], null];
        }

        $this->postReceived(Lang::translate($message), $status, $response, $options);
    }

    /**
     * Remove the data receive interface.
     */
    public function remove()
    {
        $redirect_mode = (!empty($this->request->param('redirect_mode')))
            ? $this->request->param('redirect_mode')
            : 'fixed-form~response';

        $message = 'SUCCESS_REMOVED';
        $status = 0;
        $options = [];
        $response = [[$this, 'redirect'], $redirect_mode];

        if (!parent::remove()) {
            $message = 'FAILED_REMOVE';
            $status = 1;
        }

        $this->postReceived(Lang::translate($message), $status, $response, $options);
    }
}
